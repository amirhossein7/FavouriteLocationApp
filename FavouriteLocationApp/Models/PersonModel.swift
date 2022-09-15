//
//  Person.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import Foundation


struct PersonModel {
    var id: Int
    var firstName: String
    var sureName: String
    var locations: [LocationModel]
    
    func fullName() -> String {
        return "\(firstName) \(sureName)"
    }
}

struct PeopleCellModel {
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
