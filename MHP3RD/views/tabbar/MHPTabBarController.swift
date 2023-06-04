//
//  MHPTabBarController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/4.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit

class MHPTabBarController: UITabBarController {
    
    var subContriollers: [UIViewController] {
        let map = MapScrollerViewController()
        let quest = QuestViewController()
        let monster = MonsterViewController()
        let armoury = ArmouryViewController()
        let about = AboutViewController()
        return [map, quest, monster, armoury, about]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUIContents()
    }
}

extension MHPTabBarController {
    func setupUIContents() {
        let views = subContriollers
        let names = ["图", "任", "兽", "兵", "我"]
        let imageNames = ["map", "quest", "monster", "armoury", "about"]
        
        var navs = [UINavigationController]()
        var images = [UIImage]()
        
        for i in 0..<views.count {
            let nav = UINavigationController(rootViewController: views[i])
            navs.append(nav)
            let image = UIImage(named: imageNames[i])
            images.append(image!)
        }
        
        self.viewControllers = navs
        
        for i in 0..<views.count {
            self.viewControllers![i].tabBarItem.title = names[i]
            self.viewControllers![i].tabBarItem.image = images[i]
        }
        
        self.tabBar.backgroundColor = UIColor.white
    }
}
