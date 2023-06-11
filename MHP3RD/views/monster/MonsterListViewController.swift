//
//  MonsterListViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import SnapKit

final class MonsterListViewController: UIViewController {
    
    let portraitTag = 10001
    let nameTag = 10002
    let headerTag = 10003
    
    typealias MonsterRaceInfo = (race: MONSTERTYPE, clan: [Monster])
    
    let monsterIdentifier = "monsterCellIdentifier"
    
    let monsterHeaderIdentifier = "monsterViewHeaderIdentifier"
    
    let typeForSection: [MONSTERTYPE] = [.BirdDragon, .Beast, .TeethDragon, .SeaDragon, .BeastDragon, .Dragon, .AcientDragon]
    
    let typeToStringMapping: [MONSTERTYPE: String] = [.BirdDragon: "鸟龙种", .Beast: "牙兽种", .BeastDragon: "兽龙种", .SeaDragon: "海龙种", .Dragon: "飞龙种", .AcientDragon: "古龙种", .TeethDragon: "牙龙种"]
    
    var dataSource: [MonsterRaceInfo]? = nil;
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAllMonsterInfo()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: monsterIdentifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: monsterHeaderIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
}

extension MonsterListViewController {
    func readAllMonsterInfo() {
        var result = [MonsterRaceInfo]()
        for race in typeForSection {
            let monstersOfRace = CustomPlistReader(type: .monster).monstersForType(type: race)
            result.append(MonsterRaceInfo(race, monstersOfRace))
        }
        dataSource = result
    }
}

extension MonsterListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let num = dataSource?.count ?? 0
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let monsterOfRace = self.dataSource?[section] else {
            return 0
        }
        return monsterOfRace.clan.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monsterIdentifier, for: indexPath)
        guard let monsterOfRace = self.dataSource?[indexPath.section] else {
            return cell
        }
        let monsterInfo = monsterOfRace.clan[indexPath.row]
        
        var nameLabel: UILabel? = cell.contentView.viewWithTag(nameTag) as? UILabel
        if nameLabel == nil {
            nameLabel = UILabel(frame: .zero)
            nameLabel!.text = monsterInfo.name
            nameLabel!.textAlignment = .center
            nameLabel!.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            cell.contentView.addSubview(nameLabel!)
            nameLabel!.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.bottom.equalTo(0)
            }
            nameLabel!.tag = nameTag
        }
        nameLabel!.text = monsterInfo.name
        
        let monsterPortrait = UIImage(named: monsterInfo.picPath)
        var icon: UIImageView? = cell.viewWithTag(portraitTag) as? UIImageView
        if icon == nil {
            icon = UIImageView(image: monsterPortrait)
            icon!.contentMode = .scaleAspectFit;
            icon!.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            cell.contentView.addSubview(icon!)
            icon!.snp.makeConstraints { make in
                make.top.left.right.equalTo(0)
                make.bottom.equalTo(nameLabel!.snp_topMargin).offset(-10)
            }
            icon!.tag = portraitTag
        }
        icon!.image = monsterPortrait
        return cell
    }
}

extension MonsterListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let monsterOfRace = self.dataSource?[indexPath.section] else {
            return
        }
        let monsterInfo = monsterOfRace.clan[indexPath.row]
        let monsterDetail = MonsterInfoViewController(monster: monsterInfo)
        monsterDetail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(monsterDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: monsterHeaderIdentifier, for: indexPath)
        guard let dataSource = dataSource else {
            return headerView
        }
        headerView.backgroundColor = .white
        var titleLabel: UILabel? = headerView.viewWithTag(headerTag) as? UILabel
        if titleLabel == nil {
            titleLabel = UILabel(frame: .zero)
            titleLabel!.tintColor = .black
            titleLabel!.textAlignment  = .center
            titleLabel!.font = .boldSystemFont(ofSize: 14)
            headerView.addSubview(titleLabel!)
            titleLabel!.snp.makeConstraints { make in
                make.edges.equalTo(0)
            }
            titleLabel!.tag = headerTag
        }
        titleLabel?.text = typeToStringMapping[dataSource[indexPath.section].race]
        return headerView
    }
}
