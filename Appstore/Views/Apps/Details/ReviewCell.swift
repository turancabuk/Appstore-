//
//  ReviewCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 13.01.2024.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", Font: .boldSystemFont(ofSize: 16), numberOfLines: 0)
    let authorLabel = UILabel(text: "Author", Font: .systemFont(ofSize: 16))
    let starsLabel = UILabel(text: "Stars", Font: .systemFont(ofSize: 14))
    let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n ", Font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.6156861782, green: 0.6156862974, blue: 0.6199913621, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8)
            , starsLabel, bodyLabel
        ],spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
