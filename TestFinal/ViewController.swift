//
//  ViewController.swift
//  TestFinal
//
//  Created by vPro on 24/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let url = Bundle.main.url(forResource: "Pensebete", withExtension: "json")
    
    var myTableViewDataSource = [NewInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadList()
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTableViewDataSource.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let myImageView = cell.viewWithTag(11) as! UIImageView
        let myName = cell.viewWithTag(12) as! UILabel
        let myAddress = cell.viewWithTag(13) as! UILabel
        let myType = cell.viewWithTag(14) as! UILabel

        myName.text = myTableViewDataSource[indexPath.row].name
        
        
        myAddress.text = myTableViewDataSource[indexPath.row].address
        myType.text = myTableViewDataSource[indexPath.row].type

        
        let myURL = myTableViewDataSource[indexPath.row].image_url
        loadImage(url: myURL, to: myImageView)
        
        return cell
    }
    
   
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
   
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  if segue.identifier == "affichageDetails" {
        //    if let indexPath = myTableView.indexPathForSelectedRow {
          //      let destinationController = segue.destination as! DetailsBarViewController
            //    destinationController.bar = myTableViewDataSource[indexPath.row].address
            //}
        //}
    //}
    
    func configure(location: String) {
        let geocoder = CLGeocoder()
        print(location)
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        }
    
    }

    
    
    
    
    
    
    
    
    //Charger la liste des donnees a partir fichier json
    func loadList()  {
        
        var myNews = NewInfo()
        
        let task = URLSession.shared.dataTask(with: url!){
            (data, response, error) in
            
            if error != nil
            {
                print("ERROR HERE")
            }else{
                do{
                    if let content = data
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers)
                        print(myJson)
                        
                        if let jsonData = myJson as? [String : Any]
                        {
                            if let myResults = jsonData["bars"] as? [[String : Any]]{
                                dump(myResults)
                                
                                for value in myResults {
                                    if let name = value["name"] as? String {
                                        myNews.name = name
                                    }
                                    if let address = value["address"] as? String {
                                        myNews.address = address
                                    }
                                    if let type = value["tags"] as? String {
                                        myNews.type = type
                                    }
                                    
                                    
                                    
                                    if let image_url = value["image_url"] as? String {
                                            myNews.image_url = image_url
                                        }
                                    
                                    self.myTableViewDataSource.append(myNews)
                                }
                                
                                dump(self.myTableViewDataSource)
                                DispatchQueue.main.async {
                                    self.myTableView.reloadData()
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                catch{
                    
                }
            }
           
        }
         task.resume()
    }
   
    
   
    // Charger l'image 
    func loadImage(url: String, to imageView: UIImageView)
    {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) {
            
        (data, response, error) in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }

}

