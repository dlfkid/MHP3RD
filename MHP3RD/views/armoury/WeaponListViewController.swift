//
//  WeaponListViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/11.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import SnapKit

final class WeaponListViewController: UIViewController {
    let weaponCellIdentfier = "weaponCellIdentfier"
    var dataSource: [Weapon]?
    let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupContente()
    }
    
    private func loadData() {
        dataSource = CustomPlistReader(type: .weapon).weaponInfo()
    }
    
    private func setupContente() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: weaponCellIdentfier)
        tableView.delegate = self;
        tableView.dataSource = self;
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
}

extension WeaponListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = self.dataSource else {
            return 0
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weaponCellIdentfier, for: indexPath)
        cell.selectionStyle = .none
        guard let weaponModel = self.dataSource?[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = weaponModel.name
        return cell
    }
}

extension WeaponListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weaponModel = self.dataSource?[indexPath.row] else {
            return
        }
        let infoController = WeaponInfoViewController(weapon: weaponModel)
        infoController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(infoController, animated: true)
    }
}
