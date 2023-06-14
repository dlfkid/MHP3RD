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
    var questName: String
    var questBrief: String
    var questPic: String
    var key: Bool
    var type: QuestType
}
