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
    var lastName: String
    var locations: [LocationModel]
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
}


