//
//  TodayCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 16.01.2024.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        imageView.image = #imageLiteral(resourceName: "garden")
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.centerInSuperview(size: .init(width: 200, height: 200))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
