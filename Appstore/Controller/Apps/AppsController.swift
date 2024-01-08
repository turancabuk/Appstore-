//
//  AppsController.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit


class AppsController: BaseListController, UICollectionViewDelegateFlowLayout {

    let cellId = "id"
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.register(AppsGroupCellCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return.init(width: view.frame.width, height: 250)
    }
}
