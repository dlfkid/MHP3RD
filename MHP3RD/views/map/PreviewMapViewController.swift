//
//  PreviewMapViewController.swift
//  MHP3RD
//
//  Created by LeonDeng on 2023/7/8.
//  Copyright © 2023 Ivan_deng. All rights reserved.
//

import UIKit
import Reusable

class PreviewMapViewController: UIViewController, Reusable {
    
    var collectionView: UICollectionView? = nil
    
    var dataSource = [MapModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSource()
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = UIScreen.main.bounds.size
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = .zero
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        guard let collectionView = collectionView else {
            fatalError()
        }
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: PreviewMapCollectionViewCell.self)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    func loadDataSource() {
        dataSource = MapModel.acquireAllMapModels()
    }
}

extension PreviewMapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PreviewMapCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.mapModel = dataSource[indexPath.item]
        return cell
    }
}

extension PreviewMapViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mapItem = dataSource[indexPath.item]
        let controller = DetailMapViewController(mapModel: mapItem)
        present(controller, animated: true)
    }
}
