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
    
    func getDistance(from: CLLocationCoordinate2D, metric: MetricUnit) -> DistanceModel {
        return DistanceModel(from: from, to: getLocation(), metricUnit: metric)
    }
}


struct DistanceModel {
    
    private(set) var from: CLLocationCoordinate2D
    private(set) var to: CLLocationCoordinate2D
    private(set) var metricUnit: MetricUnit
        
    var metric: String {
        return metricUnit.value()
    }
    
    var value: Double {
        let distance = Double.distanceBetweenLocations(lat1: to.latitude, lon1: to.longitude, lat2: from.latitude, lon2: from.longitude, unit: metricUnit)
        return distance
    }
    
}
