//
//  UIApplication+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/16/22.
//

import UIKit


public extension UIApplication {
    static func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}
