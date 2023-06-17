//
//  QuestIndexViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/17.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit

class QuestIndexViewController: UIViewController {
    
    enum QuestListViewControllerSection: Int {
        case village
        case guildLow
        case guildHigh
    }
    
    let cellIdentifier = "questIndexViewController.tableview.cells"
    let headerIdentifier = "questIndexViewController.tableview.headers"
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var guildHighQuests: QuestCategory?
    
    var guildLowQuests: QuestCategory?
    
    var villageQuests: QuestCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        view.addSubview(tableView)
        navigationItem.title = "任务列表"
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    func loadData() {
        villageQuests = CustomPlistReader(type: .quest).questList()
        guildLowQuests = CustomPlistReader(type: .guildlow).questList()
        guildHighQuests = CustomPlistReader(type: .guildhigh).questList()
    }
    
    func questCategoryForSection(section: Int) -> QuestCategory? {
        let option = QuestListViewControllerSection(rawValue: section)
        switch option {
        case .village:
            return villageQuests
        case .guildLow:
            return guildLowQuests
        case .guildHigh:
            return guildHighQuests
        case .none:
            return villageQuests
        }
    }
    
    func questListForIndexPath(indexPath: IndexPath) -> QuestSeries? {
        let category = questCategoryForSection(section: indexPath.section)
        return category?.questSeries[indexPath.row]
    }
    
    func questListNameForIndexPath(indexPath: IndexPath) -> String {
        let questSeries = questListForIndexPath(indexPath: indexPath)
        let starts = questSeries?.stars ?? 0
        var result = ""
        for _ in 0 ..< starts {
            result.append("⭐️")
        }
        return result
    }
}

extension QuestIndexViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = questCategoryForSection(section: section)
        return category?.questSeries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = questListNameForIndexPath(indexPath: indexPath)
        return cell
    }
}

extension QuestIndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = questListForIndexPath(indexPath: indexPath) else {
            return
        }
        let questListController = QuestListViewController(quests: model)
        navigationController?.pushViewController(questListController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: UITableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) ?? UITableViewHeaderFooterView(reuseIdentifier: headerIdentifier)
        let category = questCategoryForSection(section: section)
        header.textLabel?.text = category?.typeName
        return header
    }
}
