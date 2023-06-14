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
    
    func questList() -> [Quest] {
        var result = [Quest]()
        guard let quests = self.readPlistData() else {
            return result
        }
        for quest in quests {
            /*
             NSString *name = [info objectForKey:@"name"];
             NSString *pic = [info objectForKey:@"pic"];
             NSString *brief = [info objectForKey:@"brief"];
             BOOL key = [(NSNumber *)[info objectForKey:@"key"] boolValue];
             */
            let name = (quest as! NSDictionary).object(forKey: "name") as! String
            let pic = (quest as! NSDictionary).object(forKey: "pic") as! String
            let brief = (quest as! NSDictionary).object(forKey: "brief") as! String
            let key = (quest as! NSDictionary).object(forKey: "key") as! Bool
            var questType: QuestType = .guildLow(CustomPlistType.guildlow.rawValue)
            switch type {
            case .guildhigh:
                questType = .guildHigh(CustomPlistType.guildhigh.rawValue)
            case .quest:
                questType = .village(CustomPlistType.quest.rawValue)
            default:
                questType = .guildLow(CustomPlistType.guildlow.rawValue)
            }
            let questInfo = Quest(questName: name, questBrief: brief, questPic: pic, key: key, type: questType)
            result.append(questInfo)
        }
        return result
    }
}
