//
//  GoogleMapService.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapService {

    
    static func apiKeyConfiguration() {
        let apiKey = "AIzaSyB01r9cmLKxh75A1aiz5RgoNqXmhPEmWJw"
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
    }
}
