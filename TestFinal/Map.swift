//
//  Map.swift
//  TestFinal
//
//  Created by vPro on 24/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import MapKit
import AddressBook
import SwiftyJSON

class Map: NSObject, MKAnnotation
{
    
    
    
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    
    
    
    init(title: String,locationName: String?, coodinate: CLLocationCoordinate2D )
    {
        
        self.title = title
        self.locationName = locationName
        self.coordinate = coodinate
        
        super.init()
        
    }
   
    
    var subtitle: String? {
        return locationName
    }
    
    class func from(json: JSON) -> Map?
    {
        var title: String
        if let unwrappedTitle = json["name"].string {
            title = unwrappedTitle
        }else{
            title = ""
        }
        let locationName = json["address"].string
        let latitude = json["latitude"].doubleValue
        let longitude = json["longitude"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
       
        return Map(title: title, locationName: locationName, coodinate: coordinate)
    }
    
    func mapItem() -> MKMapItem
    {
        let addressDictioanary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictioanary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(title) \(subtitle)"
        
        return mapItem
    }
}
