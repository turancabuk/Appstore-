//
//  MultipleAppsCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 18.01.2024.
//

import UIKit


class MultipleAppsCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let companyLabel = UILabel()
    let getButton = UIButton(title: "GET")
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    var results: FeedResult! {
        didSet {
            nameLabel.text = results.name
            companyLabel.text = results.artistName
            imageView.sd_setImage(with: URL(string: results.artworkUrl100))
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.layer.cornerRadius = 8
        
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
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: -8, right: 0),
                             size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
