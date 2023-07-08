//
//  PreviewMapCollectionViewCell.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/7/8.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

class PreviewMapCollectionViewCell: UICollectionViewCell, Reusable {
    
    private let mapContainer = UIImageView(frame: .zero)
    
    private let titleLabel = UILabel(frame: .zero)
    
    var mapModel: MapModel? {
        didSet {
            mapContainer.image = UIImage(named: mapModel?.mapPreviewImageName ?? "")
            titleLabel.text = mapModel?.mapName ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        mapContainer.contentMode = .scaleToFill
        contentView.addSubview(mapContainer)
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.shadowColor = .white
        titleLabel.shadowOffset = CGSize(width: 1, height: 1)
        titleLabel.layer.shadowOpacity = 0.5
        contentView.addSubview(titleLabel)
        mapContainer.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
