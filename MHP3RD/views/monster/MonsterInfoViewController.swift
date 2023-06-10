//
//  MonsterInfoViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit

class MonsterInfoViewController: UIViewController {
    
    let monsterInfo: Monster
    
    let scrollView = UIScrollView(frame: .zero)
    
    let commonLabel: (text: String) -> UILabel = {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = .black;
        label.font = .systemFont(ofSize: .labelFontSize)
        label.lineBreakMode = .byTruncatingTail;
        return label
    }
    
    let nameLabel = {
        return commonLabel(text: monsterInfo.name)
    }()
    
    let weakNessLabel = {
        return commonLabel(text: monsterInfo.weakness)
    }()
    
    let atkStyleLabel = {
        return commonLabel(text: monsterInfo.atkStyle)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.mas_makeConstraints { make in
            edge.equalTo()(self.view)
        }
        
        let portraitView = UIImageView(frame: .zero)
        let portrait = UIImage(named: monsterInfo.picPath)
        portraitView.image = portrait
        scrollView.addSubview(portraitView)
        
        portraitView.lks_involvedRawConstraints.mas_makeConstraints { make in
            make.left.right()(0)
            make.mas_equalTo()(0)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MonsterViewController {
}
