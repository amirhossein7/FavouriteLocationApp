//
//  GoogleMapViewController.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//


import UIKit
import GoogleMaps
import GooglePlaces


class GoogleMapViewController: UIViewController{

    // MapView
    private lazy var mapView: GMSMapView = { [unowned self] in
        let mapview = GMSMapView()
        return mapview
    }()
    
    var defaultCoordinate: CLLocationCoordinate2D
    var parentDelegate: ChildToParentMapProtocol
    
    init(_ parentDelegate: ChildToParentMapProtocol,
         defaultCoordinate: CLLocationCoordinate2D){
        self.parentDelegate = parentDelegate
        self.defaultCoordinate = defaultCoordinate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createMapView(withCoordinate: defaultCoordinate)
    }

    func createMapView(withCoordinate coordinate: CLLocationCoordinate2D){
        mapView.delegate = self
        let updatedCamera = GMSCameraUpdate.setTarget(coordinate, zoom: 14.0)
        mapView.animate(with: updatedCamera)
        // Gesture
        mapView.settings.setAllGesturesEnabled(true)
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.setMinZoom(0, maxZoom: 18)
        mapView.isMyLocationEnabled = true
        mapView.isTrafficEnabled = false
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                Log("Unable to find style.json")
            }
        }catch {
            Log("One or more of the map styles failed to load. \(error)")
        }
        self.view.addSubview(self.mapView)
        addConstraint()
    }

    func addConstraint(){
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }

    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    // MARK: - ARCarMovementDelegate
    func arCarMovement(_ coord: CLLocationCoordinate2D) {
//        if !(AppDelegate.getDelegate.getTravelId().isEmpty) {
//            if AppDelegate.getDelegate.getTravelState() == "taxi_confirmed" {
//                self.moveAnimateMapview(coord, 17.0)
//            }
//        }
    }



}

extension GoogleMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        Log("didChange")
        parentDelegate.mapDidChange()
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        Log("idleAt")
        parentDelegate.mapCameraIdle(position.target)
    }

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        Log("willMove")
        parentDelegate.mapWillMove()
    }
}

//
//extension GoogleMapController: GMSMapViewDelegate{
//
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        Log("didChange")
//        parentDelegate?.mapDidChange()
//    }
//
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        Log("idleAt")
//        parentDelegate?.mapCameraIdle(position.target)
//    }
//
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        Log("willMove")
//        parentDelegate?.mapWillMove()
//    }
//}
//
//extension GoogleMapController: BaseMapProtocols{
//
//    func moveAnimateMapview(_ coord: CLLocationCoordinate2D, _ zoom: Float){
//        let updatedCamera = GMSCameraUpdate.setTarget(coord, zoom: zoom)
//        mapView.animate(with: updatedCamera)
//    }
//
//    func clearMapview(){
//        mapView.clear()
//    }
//
//    func getTargetMapView() -> CLLocationCoordinate2D{
//        if LocationService.shared.isEnableLocation() {
//            return self.mapView.camera.target
//        }
//        return CLLocationCoordinate2D()
//    }
//
//    func fitZoomCamera(_ originCoord: CLLocationCoordinate2D, _ destinationsCoords: [CLLocationCoordinate2D]){
//        var bounds = GMSCoordinateBounds()
//        bounds = bounds.includingCoordinate(originCoord)
//        for destCoord in destinationsCoords{
//            bounds = bounds.includingCoordinate(destCoord)
//        }
//        var padding = UIEdgeInsets.zero
//        let statusBar = AppDelegate.getDelegate.getHeightStatusBar()
//        let bottom = AppDelegate.getDelegate.getBottomHeight()
//        if AppDelegate.getDelegate.getTravelId().isEmpty{
//            padding = UIEdgeInsets(top: statusBar+70, left: 30, bottom: 280+bottom , right: 30)
//        }else{
//            padding = UIEdgeInsets(top: statusBar+70, left: 30, bottom: 320+bottom , right: 30)
//        }
//
//        let fitBound = GMSCameraUpdate.fit(bounds, with: padding)
//        mapView.animate(with: fitBound)
//    }
//
//    func addMarker(_ model: MarkerModel, _ type: MarkerTypes){
//        // removeMarker(model)
//        let marker: GMSMarker!
//        if let hasMarker = model.object as? GMSMarker{
//            marker = hasMarker
//        }else{
//            marker = GMSMarker()
//        }
//
//        marker.position = model.coordinate ?? CLLocationCoordinate2D()
//        marker.isTappable = false
//
//        switch type {
//        case .source:
//            marker.icon = UIImage(named: "pin_home_\(EPLocalize.currentLanguage())")!
//        case .destination:
//            marker.icon = UIImage(named: "pin_destination_\(EPLocalize.currentLanguage())")!
//        case .two_destinations:
//            marker.icon = UIImage(named: "pin_destination_second_\(EPLocalize.currentLanguage())")!
//        }
//
//        marker.map = mapView
//        model.object = marker
//    }
//
//    func removeMarker(_ model: MarkerModel){
//        guard let marker = (model.object as? GMSMarker) else {return}
//        marker.map = nil
//        model.object = nil
//    }
//
//    func addTaxiMarker(_ model: TaxiMarkerModel){
//        let serviceType = model.taxi_type ?? .normal
//        let coordinate = model.coordinate ?? CLLocationCoordinate2D()
//
//        // removeMarker(model)
//        let marker: GMSMarker!
//        if let taxiMarker = model.object as? GMSMarker{
//            marker = taxiMarker
//        }else{
//            marker = GMSMarker()
//        }
//
//        marker.position = coordinate
//        marker.isTappable = false
//        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5) // snapp anchor setup to Bottom with size 1
//        marker.appearAnimation = GMSMarkerAnimation.pop
//        marker.rotation = CLLocationDegrees(model.taxi_old_bearing)
//
//        switch serviceType {
//        case .normal:
//            marker.icon = UIImage(named: "pin_normal")
//        case .lady:
//            marker.icon = UIImage(named: "pin_lady")
//        case .vip:
//            marker.icon = UIImage(named: "pin_vip")
//        case .delivery:
//            marker.icon = UIImage(named: "pin_delivery")
//        case .truck:
//            marker.icon = UIImage(named: "pin_truck")
//        case .tank_truck:
//            marker.icon = UIImage(named: "pin_tank_truck")
//        }
//
//        marker.map = mapView
//        model.object = marker
//    }
//
//    func carMovement(marker: TaxiMarkerModel){
//
//        guard let taxiMarker = marker.object as? GMSMarker else {return}
//
//        // animation for bearing
//        CATransaction.begin()
//        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: .linear))
//        CATransaction.setAnimationDuration(1.5)
//        CATransaction.setCompletionBlock({() -> Void in
//
//        })
//        taxiMarker.rotation = CLLocationDegrees(marker.taxi_old_bearing)
//        CATransaction.commit()
//
//
//        //marker movement animation
//        CATransaction.begin()
//        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: .easeInEaseOut))
//        CATransaction.setAnimationDuration(8.0)
//        CATransaction.setCompletionBlock({() -> Void in
//            // self.arCarMovement(newCoordinate)
//        })
//
//        taxiMarker.position = marker.coordinate ?? CLLocationCoordinate2D()  //this can be new position after car moved from old position to new position with animation
//        taxiMarker.map = mapView
//        CATransaction.commit()
//
//    }
//
//    func resetMapPadding(){
//        mapView.padding = .zero
//    }
//
//    func scrollBy(x: CGFloat, y: CGFloat){
//      let downwards = GMSCameraUpdate.scrollBy(x: x, y: -y)
//      mapView.animate(with: downwards)
//    }
//
//
//    func isPinAllowed() -> Bool {
//        let currentZoom = mapView.camera.zoom
//        return currentZoom >= 15.0 ? true : false
//    }
//
//}
//
//
