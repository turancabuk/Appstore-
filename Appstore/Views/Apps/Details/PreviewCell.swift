//
//  PreviewCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 13.01.2024.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    

    let prevHorizontalController = PreviewScreenshotsController()
    let prevLabel = UILabel(text: "Preview", Font: .boldSystemFont(ofSize: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(prevLabel)
        addSubview(prevHorizontalController.view)
        
        prevLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing:  trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        prevHorizontalController.view.anchor(top: prevLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
