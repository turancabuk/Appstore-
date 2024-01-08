//
//  Extensions.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit

extension UILabel {
    convenience init(text: String, Font: UIFont){
        self.init(frame: .zero)
        self.text = text
        self.font = Font
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
