//
//  MonsterListViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/6/10.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit

class MonsterListViewController: UIViewController {
    
    typealias MonsterRaceInfo = (race: MONSTERTYPE, clan: [Monster])
    
    let monsterIdentifier = "monsterCellIdentifier"
    
    let monsterHeaderIdentifier = "monsterViewHeaderIdentifier"
    
    let typeForSection: [MONSTERTYPE] = [.BirdDragon, .Beast, .TeethDragon, .SeaDragon, .BeastDragon, .Dragon, .AcientDragon]
    
    var dataSource: [MonsterRaceInfo]? = nil;
    
    let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        return layout
    }()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        view.backgroundColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell, forCellWithReuseIdentifier: monsterIdentifier)
        collectionView.register(UICollectionReusableView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: monsterHeaderIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.mas_makeConstraints { make in
            make?.edges.equalTo()(self.view)
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
        return dataSource?.count ?? 0
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
        let monsterPortrait = UIImage(contentsOfFile: monsterInfo.picPath)
        let icon = UIImageView(image: monsterPortrait)
        cell.contentView.addSubview(icon)
        icon.mas_makeConstraints { make in
            make?.top.equalTo()(0)
        }
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
        self.navigationController?.pushViewController(monsterDetail, animated: true)
    }
}
