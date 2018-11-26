//
//  MapViewController.swift
//  TestFinal
//
//  Created by vPro on 24/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON


class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    var bars = [Map]()
    
    func fetchData() {
        let fileName = Bundle.main.path(forResource: "Pensebete", ofType:"json")
        let filePath = URL(fileURLWithPath: fileName!)
        var data: Data?
        do {
            data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
            
        } catch let error {
            data = nil
            print("Report error \(error.localizedDescription)")
        }
        
        if let jsonData = data {
            do{
                let json = try JSON(data: jsonData)
                if let barJSONS = json["bars"].array {
                    for barJSON in barJSONS {
                        if let bar = Map.from(json: barJSON) {
                            self.bars.append(bar)
                        }
                    }
                }
                
            }catch let error as NSError {
                // error
            }
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 48.860033826521, longitude: 2.3508920416641)
        zoomMapOn(location: initialLocation)
        
        //let CafeBeaubourg = Map(title: "Café Beaubourg", locationName: "100 Rue Saint-Martin, 75004 Paris, France, Opera and Les Halles, Paris", coodinate: CLLocationCoordinate2D(latitude: 48.860033826521, longitude: 2.3508920416641))
        //mapView.addAnnotation(CafeBeaubourg)
        
        mapView.delegate = self
        fetchData()
        mapView.addAnnotations(bars)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationServiceAuthentificationStatus()
    }
    
    private let regionRadius: CLLocationDistance = 1000
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 2.5, longitudinalMeters: regionRadius * 2.5)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var locationManager = CLLocationManager()
    
    func checkLocationServiceAuthentificationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        }else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}
extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        self.mapView.showsUserLocation = true
        zoomMapOn(location: location)
    }
}


extension MapViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Map {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                view = dequeuedView
                
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView =  UIButton(type: .detailDisclosure) as UIButton
            }
            return view
        
    }
        return nil
}
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Map
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}
