//
//  BaseTodayCell.swift
//  Appstore
//
//  Created by Turan Çabuk on 18.01.2024.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem!
    
    override var isHighlighted: Bool {
        didSet {
            let transform: CGAffineTransform = .init(scaleX: 0.9, y: 0.9)
            if isHighlighted {
                
                UIView.animate(
                    withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,options: .curveEaseInOut,animations:  {
                        self.transform = transform
                    })
            }else{
                self.transform = .identity
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundView = UIView()
        addSubview(self.backgroundView!)
        self.backgroundView?.fillSuperview()
        self.backgroundView?.backgroundColor = .white
        self.backgroundView?.layer.cornerRadius = 16
        self.backgroundView?.layer.masksToBounds = false
        
        self.backgroundView?.layer.shadowColor = UIColor.black.cgColor
        self.backgroundView?.layer.shadowOpacity = 0.5
        self.backgroundView?.layer.shadowRadius = 10
        self.backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
        self.backgroundView?.layer.shouldRasterize = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
