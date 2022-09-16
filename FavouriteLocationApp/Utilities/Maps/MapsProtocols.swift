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


protocol BaseMapProtocols : AnyObject {
    // Base
//    func moveAnimateMapview(_ coord: CLLocationCoordinate2D, _ zoom: Float)
//    func getTargetMapView() -> CLLocationCoordinate2D
    func addMarker(coordinate: CLLocationCoordinate2D, distance: Double, metric: String)
//    func removeMarker(_ model: MarkerModel)
    
    // Details
    func clearMapview()
//    func resetMapPadding()
    func fitZoomCamera(_ originCoord: CLLocationCoordinate2D, _ destinationsCoords: [CLLocationCoordinate2D])
//    func addTaxiMarker(_ model: TaxiMarkerModel)
//    func carMovement(marker: TaxiMarkerModel)
//    func scrollBy(x: CGFloat, y: CGFloat)
//    func isPinAllowed() -> Bool
}
