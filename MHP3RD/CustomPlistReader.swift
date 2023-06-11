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
    
    var plistName: String
    
    init(type: CustomPlistType) {
        plistName = type.rawValue
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
}
