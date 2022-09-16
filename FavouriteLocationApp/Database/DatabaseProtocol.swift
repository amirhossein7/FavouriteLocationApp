//
//  DatabaseProtocol.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation


protocol DatabaseProtocol: AnyObject {
    
    func getAllItems() -> [AnyObject]
    func getAllItemsAsPersonModel() -> [PersonModel]
    func createPerson(firstName: String, lastName: String)
    func addLocation(personsID: [Int], latitude: Double, longitude: Double)
    
}
