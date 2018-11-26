//
//  CafeTableViewController.swift
//  TestFinal
//
//  Created by vPro on 25/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import UIKit

class CafeTableViewController: UITableViewController {
    let url = Bundle.main.url(forResource: "Pensebete", withExtension: "json")
    
    var cafeNoms = [NewInfo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         loadList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return cafeNoms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CafeTableViewCell
        let myImageView = cell.viewWithTag(0) as! UIImageView
        
        
        cell.labelNom.text = cafeNoms[indexPath.row].name
        
        
        cell.labelLocation.text = cafeNoms[indexPath.row].address
        cell.labelType.text = cafeNoms[indexPath.row].type
        
        let myURL = cafeNoms[indexPath.row].image_url
        loadImage(url: myURL, to: myImageView)
        
        return cell
        
        

       
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
                                    
                                    self.cafeNoms.append(myNews)
                                }
                                
                                dump(self.cafeNoms)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
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
