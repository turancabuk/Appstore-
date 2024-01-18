//
//  TodayMultipleAppCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 18.01.2024.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    let multipleAppsController = UIViewController()

    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title

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
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, multipleAppsController.view
        ], spacing:  12)
         
        addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
