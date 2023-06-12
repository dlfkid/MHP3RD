//
//  WeaponInfoViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/11.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit

class WeaponInfoViewController: UIViewController {
    
    let iconTag = 10001
    
    let cellIdentifier = "weaponCellIdentifier"
    
    let weapon: Weapon
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    init(weapon: Weapon) {
        self.weapon = weapon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = weapon.name
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
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

extension WeaponInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if indexPath.row == 0 {
            cell?.textLabel?.text = weapon.name
        } else if indexPath.row == 1 {
            cell?.textLabel?.text = weapon.brief
            cell?.textLabel?.numberOfLines = 0
        } else if indexPath.row == 2 {
            cell?.textLabel?.text = nil
            var iconView: UIImageView? = cell?.contentView.viewWithTag(iconTag) as? UIImageView
            if iconView == nil {
                iconView = UIImageView(image: UIImage(named: weapon.pic))
                cell?.contentView.addSubview(iconView!)
                iconView?.snp.makeConstraints({ make in
                    make.top.left.right.equalTo(0)
                    make.height.lessThanOrEqualTo(200)
                })
                iconView?.tag = iconTag
            }
            iconView?.contentMode = .scaleAspectFill
            iconView!.image = UIImage(named: weapon.pic)
        }
        return cell!
    }
    
    
}
