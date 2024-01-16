//
//  TodayController.swift
//  Appstore
//
//  Created by Turan Çabuk on 16.01.2024.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
        navigationController?.navigationBar.isHidden = true

    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("animate fullscreen somehow")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width - 64, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 32
    }
}
