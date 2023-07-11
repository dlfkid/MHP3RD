//
//  MineDataModel.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/7/11.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import Foundation

enum MineDataModelType {
    case about
}

struct MineDataModel {
    let name: String
    let type: MineDataModelType
}
