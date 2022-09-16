//
//  Location.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import Foundation
import CoreLocation

struct LocationModel {
    var latitude: Double
    var longitude: Double
    
    func getLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

