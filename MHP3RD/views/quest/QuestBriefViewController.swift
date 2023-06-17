//
//  QuestBriefViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/16.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit

class QuestBriefViewController: UIViewController {
    
    let quest:Quest
    
    let titleLabel: UILabel = {
        let result = UILabel()
        result.textAlignment = .center
        result.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return result
    }()
    
    let briefLabel: UILabel = {
        let result = UILabel()
        result.textAlignment = .left
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 14)
        return result
    }()
    
    let imageView = UIImageView(frame: .zero)
    
    init(quest: Quest) {
        self.quest = quest
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = quest.questName
        imageView.image = UIImage(named: quest.questPic)
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        
        titleLabel.textColor = quest.key ? .red : .black
        titleLabel.text = quest.questName
        view.addSubview(titleLabel)

        briefLabel.textColor = quest.key ? .red : .black
        briefLabel.text = quest.questBrief
        view.addSubview(briefLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.top.equalTo(view.safeAreaInsets.top)
            make.height.lessThanOrEqualTo(220)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(imageView.snp.bottom).offset(12)
        }
        
        briefLabel.snp.makeConstraints { make in
            make.left.right.equalTo(imageView)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
    }
}
