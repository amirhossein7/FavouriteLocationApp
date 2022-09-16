//
//  Double+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/16/22.
//

import Foundation


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    /// Calculate distance between two location coordinate
    static func distanceBetweenLocations(lat1: Double, lon1: Double, lat2: Double, lon2: Double, unit: MetricUnit) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
        dist = acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515
        if (unit == .kilometers) {
            dist = dist * 1.609344
        }
        else if (unit == .nautical_miles) {
            dist = dist * 0.8684
        }
        return dist
    }
    
}


enum MetricUnit {
    case miles
    case kilometers
    case nautical_miles
    
    func value() -> String {
        switch self {
        case .miles:
            return "mile"
        case .kilometers:
            return "Km"
        case .nautical_miles:
            return "NM"
        }
    }
}


private extension Double {
    
    ///  This function converts  decimal degrees to radians
    static func deg2rad(_ deg: Double) -> Double {
        return deg * Double.pi / 180
    }

    ///  This function converts radians to decimal degrees
    static func rad2deg(_ rad: Double) -> Double {
        return rad * 180.0 / Double.pi
    }
}
