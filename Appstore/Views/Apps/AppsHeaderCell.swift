//
//  AppsHeaderCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    var socialApps: SocialApps! {
        didSet{
            companyLabel.text = socialApps.name
            titleLabel.text = socialApps.tagline
            imageView.sd_setImage(with: URL(string: socialApps.imageUrl))
        }
    }
    let companyLabel = UILabel()
    let titleLabel = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        companyLabel.textColor = .blue
        companyLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 24)
        imageView.layer.cornerRadius = 8
        
        
        let stackView = VerticalStackView(arrangedSubviews: [
        companyLabel, titleLabel, imageView
        ], spacing:  12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
