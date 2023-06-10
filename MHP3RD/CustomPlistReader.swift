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

struct CustomPlistReader {
    let plistName: String;
    
    var plistPath: String {
        var documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let result = documentDir?.appending(self.plistName) ?? ""
        return result
    }
    
    init(type: CustomPlistType) {
        plistName = String("\(type).plist")
    }
    
    func monstersForType(type: MONSTERTYPE) -> [Monster] {
        let allMonster = NSArray(contentsOfFile: self.plistPath)
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
}
