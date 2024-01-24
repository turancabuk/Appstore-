//
//  MusicLoadingFooter.swift
//  Appstore
//
//  Created by Turan Çabuk on 24.01.2024.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let label = UILabel(text: "Loading more...", Font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubviews: [
            aiv, label
            ], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
