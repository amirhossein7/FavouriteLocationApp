//
//  MapsProtocols.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import Foundation
import CoreLocation

protocol ChildToParentMapProtocol: AnyObject {
    func mapDidChange()
    func mapCameraIdle(_ position: CLLocationCoordinate2D)
    func mapWillMove()
}
