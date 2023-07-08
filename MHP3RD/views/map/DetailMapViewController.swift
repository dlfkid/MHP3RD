//
//  DetailMapViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/7/8.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import SnapKit

class DetailMapViewController: UIViewController {
    
    let mapModel: MapModel
    
    let scrollView = UIScrollView(frame: .zero)
    
    init(mapModel: MapModel) {
        self.mapModel = mapModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapImage = UIImage(named: mapModel.mapDetailImageName)
        let contentHeight = (mapImage?.size.height ?? 0) * 2
        let contentWidth = (mapImage?.size.width ?? 0) * 2
        
        scrollView.minimumZoomScale = 1.5
        scrollView.maximumZoomScale = 3
        scrollView.zoomScale = 3
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        let mapImageView = UIImageView(image: mapImage)
        mapImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(mapImageView)
        mapImageView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.centerY.equalTo(scrollView.snp.centerY)
            make.height.equalTo(contentHeight)
            make.width.equalTo(contentWidth)
        }
    }
    
}
