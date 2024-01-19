//
//  TodayCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 16.01.2024.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
            backgroundColor = todayItem.backgroundColor
        }
    }
    
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let imageView = UIImageView()    
    let descriptionLabel = UILabel()
    var topConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        titleLabel.numberOfLines = 0
        categoryLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.font = .boldSystemFont(ofSize: 26)
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, imageContainerView, descriptionLabel
            ], spacing: 8)
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
