//
//  CellViewModel.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/19/22.
//

import Foundation


struct CellViewModel {
    var person: PersonModel
    private(set) var isSelected: Bool
    
    init(person: PersonModel) {
        self.person = person
        isSelected = false
    }
    
    mutating func select() {
        isSelected = !isSelected
    }
    
    mutating func unSelect() {
        isSelected = false
    }
    
}

