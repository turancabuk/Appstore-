//
//  AppsHorizontalController.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {

    let celld = "cellId"
    var appGroup: AppGroup?
    var didSelectHandler: ((FeedResult) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: celld)
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appGroup?.feed.title.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: celld, for: indexPath) as! AppRowCell
        let app = appGroup?.feed.results[indexPath.item]

        DispatchQueue.main.async {
            cell.nameLabel.text = app?.name
            cell.companyLabel.text = app?.artistName
            cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
  
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let app = appGroup?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
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
