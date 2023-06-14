//
//  QuestListViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/14.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import SnapKit

class QuestListViewController: UIViewController {
    
    let questCollectionCellIdentifier = "questCollectionCellIdentifier"
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var dataSource: [Quest]
    
    init(quests: [Quest]) {
        dataSource = quests
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension QuestListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: questCollectionCellIdentifier, for: indexPath)
        let model = dataSource[indexPath.row]
        cell.textLabel?.text = model.questName
        return cell
    }
}

extension QuestListViewController: UITableViewDelegate {
    
}
