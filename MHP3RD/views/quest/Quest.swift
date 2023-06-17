//
//  Quest.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/14.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import Foundation

enum QuestType {
    case village(_ typeName: String)
    case guildLow(_ typeName: String)
    case guildHigh(_ typeName: String)
}

struct Quest {
    let questName: String
    let questBrief: String
    let questPic: String
    let key: Bool
}

struct QuestSeries {
    let stars: UInt8
    let quests: [Quest]
}

struct QuestCategory {
    let type: QuestType
    
    var typeName: String {
        switch type {
        case .guildHigh(let typeNameString1):
            return typeNameString1
        case .guildLow(let typeNameString2):
            return typeNameString2
        case .village(let typeNameString3):
            return typeNameString3
        }
    }
    
    let questSeries: [QuestSeries]
}
