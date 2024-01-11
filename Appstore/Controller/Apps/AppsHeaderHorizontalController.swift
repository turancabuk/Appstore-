//
//  AppsHeaderHorizontalController.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

class AppsHeaderHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var socialApps = [SocialApps]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return socialApps.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
        
        DispatchQueue.main.async {
            let apps = self.socialApps[indexPath.item]
            cell.companyLabel.text = apps.name
            cell.titleLabel.text = apps.tagline
            cell.imageView.sd_setImage(with: URL(string: apps.imageUrl))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 0, left: 16, bottom: 0, right: 0)
    }
}
