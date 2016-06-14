//
//  ViewController.swift
//  EjercicioMapa
//
//  Created by Luis Gómez on 10/6/16.
//  Copyright © 2016 luisgomez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var mapa: MKMapView!
    var locationManager: CLLocationManager?
     // var location2: CLLocation? { get }
    
    
    @IBAction func botonMapa(sender: UIButton) {
        
        mapa.mapType = MKMapType.Standard
    }

    @IBAction func botonSatelite(sender: UIButton) {
        
       mapa.mapType = MKMapType.Satellite
        
        
    }
    
    @IBAction func botonHibrido(sender: UIButton) {
        
        mapa.mapType = MKMapType.Hybrid
    }
    
     // private let manejador = CLLocationManager()
    var origen : CLLocation = CLLocation(latitude:-122.023441039662, longitude: 37.3302332568037)
     var punto = CLLocationCoordinate2D()
    var distance = CLLocationDistance()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager!.startUpdatingLocation()
            
            
            
            
        } else {
            locationManager!.requestWhenInUseAuthorization()
        }
        
   
       
    }

    
    

    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        
        switch status {
        case .NotDetermined:
            print("NotDetermined")
        case .Restricted:
            print("Restricted")
        case .Denied:
            print("Denied")
        case .AuthorizedAlways:
            print("AuthorizedAlways")
        case .AuthorizedWhenInUse:
            print("AuthorizedWhenInUse")
            locationManager!.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
         mapa.showsUserLocation = true
        
        let location = locations.first!
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        mapa.setRegion(coordinateRegion, animated: true)
        //locationManager?.stopUpdatingLocation()
        //locationManager = nil
        
        
        
    
        
        
        punto.latitude = mapa.userLocation.coordinate.latitude
        punto.longitude = mapa.userLocation.coordinate.longitude
        
        let firstLoc = CLLocation(latitude: origen.coordinate.latitude, longitude: origen.coordinate.longitude)
       var secondLoc = CLLocation(latitude: punto.latitude, longitude: punto.longitude)
        
        
        distance = firstLoc.distanceFromLocation(secondLoc)
        
        
        
       

        
        if (distance <= 50){
           distance = 0
            
            let pin = MKPointAnnotation()
            pin.title = "\(mapa.userLocation.coordinate.latitude) - \(mapa.userLocation.coordinate.longitude)"

            pin.subtitle = "\(distance)"
            pin.coordinate = punto
            mapa.addAnnotation(pin)
            
            
        
            
        }else{
        
        
        
            print("\(distance)")
                print("\(firstLoc)")
                print("\(secondLoc)")
      
        }
        
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to initialize GPS: ", error.description)
    }
}

    

    



