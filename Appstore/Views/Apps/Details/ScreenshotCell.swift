//
//  ScreenshotCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 13.01.2024.
//

import UIKit

class ScreenShotCell: UICollectionViewCell {
  
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
