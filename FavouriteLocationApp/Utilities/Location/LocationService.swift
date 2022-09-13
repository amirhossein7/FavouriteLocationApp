//
//  LocationService.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit
import CoreLocation



class LocationService: NSObject{
    
    let locationManager = CLLocationManager()
    
    struct LocationServiceStatic {
        static var instance: LocationService?
    }
    
    class var shared: LocationService {
        if LocationServiceStatic.instance == nil {
            LocationServiceStatic.instance = LocationService()
        }
        
        return LocationServiceStatic.instance!
    }
    
    
    override init(){
        super.init()
        
        locationManager.delegate = nil
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = CLActivityType.automotiveNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.stopUpdatingLocation()
        requestAuthorization()
        
    }
    
    func dispose(){
        LocationService.LocationServiceStatic.instance = nil
    }
    
    deinit {}
    
}


// Delegates
extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // The locations array is sorted in chronologically ascending order, so the
        // last element is the most recent
        guard let location = locations.last else {return}
        
        
        // do stuff here
        if location.coordinate.latitude != 0.0 {
            Log("Location: \(location.coordinate)")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        Log("Error location: \(error)")
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
            case .authorizedWhenInUse, .authorizedAlways:
                Log("authorized")
                beginWhenInUseApp()
                
            case .denied:
                Log("denied")
                break
                
            case .notDetermined:
                Log("not determined")
                
            case .restricted:
                Log("restricted")
                
            @unknown default:
                break
            }
            
            switch manager.accuracyAuthorization{
            case .fullAccuracy:
                Log("full Accuracy")
                break
            case .reducedAccuracy:
                Log("reduced Accuracy")
                break
                
            @unknown default:
                break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            Log("authorized")
            
            beginWhenInUseApp()
            break
            
        case .denied:
            Log("denied")
            break
            
        case .notDetermined:
            Log("not determined")
            break
            
        case .restricted:
            Log("restricted")
            break
            
        @unknown default:
            return
        }
    }
}


// handler
extension LocationService {
    
    
    func getMyLocation() -> CLLocationCoordinate2D {
        guard isEnableLocation(), let location = locationManager.location else {
            return CLLocationCoordinate2D()
        }
        return location.coordinate
    }

    func requestAuthorization(){
        locationManager.requestWhenInUseAuthorization()
    }

    func beginWhenInUseApp(){
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
//            if AppDelegate.getDelegate.mainViewControllerLoaded{
//                timer.invalidate()
//                // post to Main Controller
//                if !AppDelegate.getDelegate.getCustomerId().isEmpty && AppDelegate.getDelegate.getTravelId().isEmpty{
//                    if let topVC = UIApplication.topViewController(), topVC.isKind(of: KYDrawerController.self){
//                        NotificationCenter.default.post(name: .initAuthorizeLocation, object: nil)
//                    }
//                }
//            }
        }
    }

    
    func isEnableLocation() ->Bool {
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus{
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                default:
                    break
                }
            }else{
                switch(CLLocationManager.authorizationStatus()) {
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                default:
                    break
                }
            }
        }
        return false
    }
    
    @available(iOS 14.0, *)
    func isEnableReducedAccuracy() -> Bool{
        return self.locationManager.accuracyAuthorization == .reducedAccuracy
    }
    
    
    
    func isAuthorizedAlways() -> Bool{
        if #available(iOS 14.0, *) {
            if locationManager.authorizationStatus == .authorizedAlways{
                return true
            }
        }else{
            if CLLocationManager.authorizationStatus() == .authorizedAlways{
                return true
            }
        }
        return false
    }
    
    
    
    func isAuthorizedWhenInUse() -> Bool{
        if #available(iOS 14.0, *) {
            if locationManager.authorizationStatus == .authorizedWhenInUse{
                return true
            }
        }else{
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                return true
            }
        }
        return false
    }

}

extension LocationService {
    
    @available(iOS 14.0, *)
    func showEnablePreciseLocation(_ vc: UIViewController){
        if self.isEnableLocation(){
//            let dialogPop = DialogPop(VC: vc, title:"\(Bundle.usedInAppName)", message: "Please Enable your Location" , type:"location_setting")
//            dialogPop.dialogPopopFreeGesture()
        }
    }
    
    func showEnableLocation(){
        let msg = "Please Enable your Location"
        self.gotoEnableLocationSetting(msg)
    }
    
    func gotoEnableLocationSetting(_ message: String){
        let title = "Notice"
        var actions = [(String, UIAlertAction.Style)]()
        actions.append(("Settings", .default))
        actions.append(("Cancel", .cancel))
        AlertController.showAlertDialog(title, message, actions, completion: { [weak self] (alertIndex) in
            guard let _ = self else { return }
            switch alertIndex{
            case 0:
                let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(settingsUrl)
            default:
                break
            }
        })
    }
}

