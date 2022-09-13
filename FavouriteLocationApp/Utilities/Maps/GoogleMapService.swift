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
//        GMSPlacesClient.provideAPIKey(apiKey)
    }
    
    static func generateMapView(_ parent: UIViewController) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: parent.view.frame, camera: camera)
        mapView.settings.setAllGesturesEnabled(true)
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.setMinZoom(0, maxZoom: 18)
        mapView.isMyLocationEnabled = true
        mapView.isTrafficEnabled = false
        return mapView
    }
}
