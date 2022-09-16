//
//  UIView+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/16/22.
//

import UIKit

extension UIView {
    
    func addTapGesture(tapNumber : Int, target: Any , action : Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
    }
    
}


