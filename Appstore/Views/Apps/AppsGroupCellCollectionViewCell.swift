//
//  AppsGroupCellCollectionViewCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

class AppsGroupCellCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "App Section", Font: .boldSystemFont(ofSize: 30))
    
    let horizontalController = AppsHorizontalController()
  
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .blue
        
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UILabel {
    convenience init(text: String, Font: UIFont){
        self.init(frame: .zero)
        self.text = text
        self.font = Font
    }
}
