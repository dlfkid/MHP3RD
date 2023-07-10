//
//  Monster.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import Foundation

enum MISSIONTYPE: Int {
    case VILLAGE = 0
    case GUILD_LOW = 1
    case GUILD_HIGH = 2
}

enum MONSTERTYPE: Int {
case BirdDragon = 0
case Beast = 1
case TeethDragon = 2
case SeaDragon = 3
case BeastDragon = 4
case Dragon = 5
case AcientDragon = 6
}

struct Monster {
    let name: String
    let picPath: String
    let weakness: String
    let atkStyle: String
    let type: MONSTERTYPE
}
