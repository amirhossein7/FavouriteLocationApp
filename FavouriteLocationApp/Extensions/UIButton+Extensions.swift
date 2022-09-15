//
//  UIButton+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import UIKit

extension UIButton {
    
    func addShadow(color: UIColor = .black, opacity: Float = 0.1, offSet: CGSize = CGSize(width: 0.0, height: 0.0), radius: CGFloat = 6.0, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
    }
}
