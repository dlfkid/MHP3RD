//
//  WeaponInfoViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/11.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit

class WeaponInfoViewController: UIViewController {
    
    let weapon: Weapon
    
    init(weapon: Weapon) {
        self.weapon = weapon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
