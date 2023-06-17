//
//  CustomPlistReader.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import Foundation

enum CustomPlistType: String {
    case guildlow = "guildlow"
    case guildhigh = "guildhigh"
    case quest = "quest"
    case weapon = "weapon"
    case monster = "Monster"
}

protocol PlistDataReadable {
    
    var plistName: String { get }
    
    var plistPath: String { get }
    
    func readPlistData() -> NSArray?
}

extension PlistDataReadable {
    var plistPath: String {
        let result = Bundle.main.path(forResource: plistName, ofType: "plist")
        return result ?? ""
    }
    
    func readPlistData() -> NSArray? {
        return NSArray(contentsOfFile: plistPath)
    }
}

struct CustomPlistReader: PlistDataReadable {
    
    let type: CustomPlistType
    
    var plistName: String {
        return type.rawValue
    }
    
    init(type: CustomPlistType) {
        self.type = type
    }
    
    func monstersForType(type: MONSTERTYPE) -> [Monster] {
        let allMonster = self.readPlistData()
        let monsterArray = allMonster![Int(type.rawValue)] as! NSArray
        var result = [Monster]()
        for monster in monsterArray {
            let name = (monster as! NSDictionary).object(forKey: "name") as! String
            let pic = (monster as! NSDictionary).object(forKey: "pic") as! String
            let weak = (monster as! NSDictionary).object(forKey: "weak") as! String
            let atk = (monster as! NSDictionary).object(forKey: "atk") as! String
            let newMonster = Monster(name: name, picPath: pic, weakness: weak, atkStyle: atk, type: type)
            result.append(newMonster)
        }
        return result
    }
    
    func weaponInfo() -> [Weapon] {
        var result = [Weapon]()
        guard let weapons = self.readPlistData() else {
            return result
        }
        for weaponDic in weapons {
            let name = (weaponDic as! NSDictionary).object(forKey: "name") as! String
            let pic = (weaponDic as! NSDictionary).object(forKey: "pic") as! String
            let brief = (weaponDic as! NSDictionary).object(forKey: "brief") as! String
            let weaponElement = Weapon(name: name, pic: pic, brief: brief)
            result.append(weaponElement)
        }
        return result
    }
    
    func questList() -> QuestCategory {
        var questType: QuestType = .guildLow("集会所下位任务")
        var baseStar = 1
        switch type {
        case .guildhigh:
            questType = .guildHigh("集会所上位任务")
            baseStar = 6
        case .quest:
            questType = .village("村任务")
        default:
            questType = .guildLow("集会所下位任务")
        }
        
        guard let questSeriesCollection = self.readPlistData() else {
            return QuestCategory(type: questType, questSeries: [])
        }
        var result = [QuestSeries]()
        for (index, value) in questSeriesCollection.enumerated() {
            guard let quests: NSArray = value as? NSArray else {
                continue
            }
            var questModels = [Quest]()
            for quest in quests {
                let name = (quest as! NSDictionary).object(forKey: "name") as! String
                let pic = (quest as! NSDictionary).object(forKey: "pic") as! String
                let brief = (quest as! NSDictionary).object(forKey: "brief") as! String
                let key = (quest as! NSDictionary).object(forKey: "key") as! Bool
                let questInfo = Quest(questName: name, questBrief: brief, questPic: pic, key: key)
                questModels.append(questInfo)
            }
            // 构造这个星级的任务集合
            let questSeries = QuestSeries(stars: UInt8(index + baseStar), quests: questModels)
            result.append(questSeries)
        }
        let category = QuestCategory(type: questType, questSeries: result)
        return category
    }
}
