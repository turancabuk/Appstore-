//
//  BaseListController.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    
    init() {
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
