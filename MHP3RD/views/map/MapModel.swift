//
//  MapModel.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/7/8.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import Foundation

struct MapModel {
    let mapName: String
    let mapPreviewImageName: String
    let mapDetailImageName: String
    
    static func acquireAllMapModels() -> [MapModel] {
        let dongtu = MapModel(mapName: "冻土", mapPreviewImageName: "mapDongtuCover", mapDetailImageName: "dongtu")
        let xiliu = MapModel(mapName: "溪流", mapPreviewImageName: "mapXiliuCover", mapDetailImageName: "xiliu")
        let gudao = MapModel(mapName: "孤岛", mapPreviewImageName: "mapGudaoCover", mapDetailImageName: "gudao")
        let shuimolin = MapModel(mapName: "水没林", mapPreviewImageName: "mapShuimolinCover", mapDetailImageName: "shuimolin")
        let shayuan = MapModel(mapName: "沙原", mapPreviewImageName: "mapShayuanCover", mapDetailImageName: "shayuan")
        let huoshan = MapModel(mapName: "火山", mapPreviewImageName: "mapHuoshanCover", mapDetailImageName: "huoshan")
        return [xiliu, shuimolin, gudao, shayuan, dongtu, huoshan]
    }
}
