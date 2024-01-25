//
//  AppRowCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel(text: "Deneme")
    let companyLabel = UILabel(text: "deneme")
    let getButton = UIButton(title: "GET")
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.layer.cornerRadius = 8
        imageView.image = #imageLiteral(resourceName: "garden")
        
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.numberOfLines = 2
        companyLabel.font = .systemFont(ofSize: 13)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView = UIStackView(arrangedSubviews: [
        imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel]), getButton])
        
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
