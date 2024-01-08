//
//  AppsHorizontalController.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

class AppsHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout {

    let celld = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: celld)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: celld, for: indexPath)

        return cell
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return lineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
    }
}
