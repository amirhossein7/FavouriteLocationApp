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
    func createPerson(firstName: String, sureName: String)
    func addLocation(person: AnyObject, latitude: Double, longitude: Double)
    
}
