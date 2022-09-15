//
//  String+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation


extension String {
    
    var length: Int {
        return self.count
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
}
