//
//  MineViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/7/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class MineViewController: UIViewController {
    
    let mineData:[MineDataModel] = {
        var mineDatasources = [MineDataModel]()
        mineDatasources.append(MineDataModel(name: "关于", type: .about))
        return mineDatasources
    }()
    
    let tableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的"
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: UITableViewCell.self)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
}

extension MineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mineData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        let model = mineData[indexPath.row]
        cell.textLabel?.text = model.name
        return cell
    }
}

extension MineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = mineData[indexPath.row]
        switch model.type {
        case .about:
            let controller = AboutViewController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension UITableViewCell: Reusable {
    
}
