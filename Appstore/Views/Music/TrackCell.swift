//
//  TrackCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 23.01.2024.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 6)
    let songLabel = UILabel(text: "", Font: .boldSystemFont(ofSize: 16), numberOfLines: 0)
    let artistLabel = UILabel(text: "", Font: .systemFont(ofSize: 14), numberOfLines: 0)
    var results = [Result]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 16
        imageView.constrainWidth(constant: 86)
        imageView.constrainHeight(constant: 86)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, VerticalStackView(arrangedSubviews: [
            songLabel, artistLabel
            ], spacing: 4)
        ], customSpacing:  16)
        
        addSubview(stackView)
        stackView.alignment = .center
        
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowRadius = 10
        stackView.layer.shadowOffset = .init(width: 0, height: 2)

        stackView.backgroundColor = #colorLiteral(red: 0.9423103929, green: 0.9410001636, blue: 0.9745038152, alpha: 1)
        stackView.layer.cornerRadius = 12
        stackView.fillSuperview(padding: .init(
            top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
