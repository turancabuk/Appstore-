//
//  TodayMultipleAppCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 18.01.2024.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    let multipleAppsController = MultipleAppsController(mode: .small )

    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            backgroundColor = todayItem.backgroundColor
            
            multipleAppsController.results = todayItem.apps
            multipleAppsController.collectionView.reloadData()
        }
    }
    let categoryLabel = UILabel()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        

        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = false
        
        titleLabel.numberOfLines = 0
        categoryLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.font = .boldSystemFont(ofSize: 26)

        
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
