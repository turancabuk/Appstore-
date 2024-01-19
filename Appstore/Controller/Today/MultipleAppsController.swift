//
//  MultipleAppsController.swift
//  Appstore
//
//  Created by Turan Çabuk on 18.01.2024.
//

import UIKit

class MultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var results =  [FeedResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MultipleAppsCell.self, forCellWithReuseIdentifier: cellId)
    
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return results.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppsCell
        cell.results = results[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 64)
    }
}
