//
//  MonsterInfoViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import SnapKit

final class MonsterInfoViewController: UIViewController {
    
    init(monster: Monster) {
        monsterInfo = monster
        nameLabel = commonLabel(monsterInfo.name)
        weakNessLabel = commonLabel(monsterInfo.weakness)
        atkStyleLabel = commonLabel(monsterInfo.atkStyle)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var monsterInfo: Monster
    
    let scrollView: UIScrollView = {
        let result = UIScrollView(frame: .zero)
        result.alwaysBounceVertical = true;
        result.zoomScale = 1
        result.maximumZoomScale = 1
        result.minimumZoomScale = 1
        return result
    }()
    
    var commonLabel: (_ text: String) -> UILabel = {text in
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0;
        label.lineBreakMode = .byWordWrapping;
        label.textAlignment = .center;
        label.textColor = .black;
        label.lineBreakMode = .byTruncatingTail;
        return label
    }
    
    var nameLabel: UILabel
    
    var weakNessLabel: UILabel
    
    var atkStyleLabel: UILabel

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = monsterInfo.name
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaInsets.top)
            make.bottom.equalTo(-self.view.safeAreaInsets.bottom)
            make.left.right.equalTo(0)
        }
        let portraitView = UIImageView(frame: .zero)
        let portrait = UIImage(named: monsterInfo.picPath)
        portraitView.image = portrait
        portraitView.contentMode = .scaleAspectFit
        scrollView.addSubview(portraitView)
        portraitView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.lessThanOrEqualTo(200)
            make.width.lessThanOrEqualTo(view.bounds.size.width - 20)
            make.top.equalTo(10)
        }
        
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.width.lessThanOrEqualTo(view.bounds.size.width - 20)
            make.top.equalTo(portraitView.snp_bottomMargin).offset(10)
            
        }
        
        scrollView.addSubview(atkStyleLabel)
        atkStyleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(10)
            make.width.lessThanOrEqualTo(view.bounds.size.width - 20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        scrollView.addSubview(weakNessLabel)
        weakNessLabel.snp.makeConstraints { make in
            make.top.equalTo(atkStyleLabel.snp_bottomMargin).offset(10)
            make.width.lessThanOrEqualTo(view.bounds.size.width - 20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
    }
}
