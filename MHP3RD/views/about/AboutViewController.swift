//
//  AboutViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/7/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import SnapKit

class AboutViewController: UIViewController {
    
    let backgroundImageView = UIImageView(image: UIImage(named: "aboutBackGround"))
    
    let aboutAuthorLabel = UILabel(frame: .zero)
    
    let allNameLabel = UILabel(frame: .zero)
    
    let emailLabel = UILabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "关于"
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        aboutAuthorLabel.text = "RavenDeng"
        aboutAuthorLabel.textAlignment = .center
        aboutAuthorLabel.textColor = .white
        aboutAuthorLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        view.addSubview(aboutAuthorLabel)
        aboutAuthorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.left.right.equalTo(0)
        }
        
        emailLabel.text = "dlfkid@icloud.com"
        emailLabel.textColor = .white
        emailLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutAuthorLabel.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        allNameLabel.text = "怪物猎人携带版3rd攻略书"
        allNameLabel.textColor = .white
        allNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        view.addSubview(allNameLabel)
        allNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(aboutAuthorLabel.snp.top).offset(-16)
            make.centerX.equalTo(view.snp.centerX)
        }
    }

}
