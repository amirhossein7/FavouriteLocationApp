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

extension GoogleMapViewController: BaseMapProtocols {
    
    
    func addMarker(coordinate: CLLocationCoordinate2D, distance: Double, metric: String){
        let marker = GMSMarker()

        marker.title = "\(distance)"
        marker.snippet = metric
        marker.position = coordinate
        marker.isTappable = true
        marker.infoWindowAnchor = CGPoint(x: 0.44, y: 0.45)
        marker.appearAnimation = GMSMarkerAnimation.pop

        marker.map = mapView
    }
    
    func clearMapview(){
        mapView.clear()
    }
    
    func fitZoomCamera(_ originCoord: CLLocationCoordinate2D, _ destinationsCoords: [CLLocationCoordinate2D]){
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(originCoord)
        for destCoord in destinationsCoords{
            bounds = bounds.includingCoordinate(destCoord)
        }
        var padding = UIEdgeInsets.zero
        let statusBar = SizeHandler.getHeightStatusBar()
        let bottom = SizeHandler.getBottomHeight()
        
        padding = UIEdgeInsets(top: statusBar+70, left: 30, bottom: 320+bottom , right: 30)
        
        let fitBound = GMSCameraUpdate.fit(bounds, with: padding)
        mapView.animate(with: fitBound)
    }
    
}

