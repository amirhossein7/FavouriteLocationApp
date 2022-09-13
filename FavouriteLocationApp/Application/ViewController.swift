//
//  ViewController.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var mapView: GMSMapView!
    
    @IBOutlet weak var customview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GoogleMapService.apiKeyConfiguration()
        mapView = GoogleMapService.generateMapView(self)
        self.view.addSubview(mapView)
        
        self.view.bringSubviewToFront(customview)
    }


}

