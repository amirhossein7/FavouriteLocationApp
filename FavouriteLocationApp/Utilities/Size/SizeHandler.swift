//
//  SizeHandler.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/16/22.
//

import UIKit


class SizeHandler {
    
    
    static let cornerRadius = 10
    
    static func getHeightStatusBar() -> CGFloat{
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
            case 480:
                Log("iPhone(Legacy) & iPod Touch, 1st, 2nd and 3rd Generation")
                break
            case 960:
                Log("iPhone 4 or 4S")
                break
            case 1136:
                Log("iPhone 5 or 5S or 5C or SE")
                break
            case 1334:
                Log("iPhone 6/6S/7/8")
                break
            case 1920, 2208:
                Log("iPhone 6+/6S+/7+/8+")
                break
            case 2436:
                Log("iPhone X, Xs")
                return 44
            case 2688:
                Log("iPhone Xs Max")
                return 44
            case 1792:
                Log("iPhone Xr")
                return 44
                
            default:
                Log("unknown")
            }
        }
        
        return 20
    }
    
    static func getBottomHeight() -> CGFloat {
        
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        }
        return 20.0
        
    }
}
