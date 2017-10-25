//
//  PlaceTableVC.swift
//  FourSquareTask
//
//  Created by RANDOM on 10/24/17.
//  Copyright © 2017 RANDOM. All rights reserved.
//

import UIKit
import FoursquareAPIClient
typealias DownloadComplete = () -> ()

class PlaceTableVC: UITableViewController {
    
    @IBOutlet var placeTbl: UITableView!
    var places = [Place]()
    var selectedPlace: Place!
    let client = FoursquareAPIClient(clientId:"CZPVCRCL3J4W4ZY2SDB0XD4OURPW0J4VKL54UPQY50HYQ5EK", clientSecret:"M2TJMFYIVVDUVSVQGVEZ3M2FWN3AIASI3E2LKFXEXB0YMOZ5", version: "20170801")
     var json: Any!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        placeTbl.delegate = self
        placeTbl.dataSource = self
        
        exploreVenues {
            self.completePlaceDetail()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       // print(client)
    }
    
    func exploreVenues(completed: @escaping DownloadComplete){
        let parameter: [String: String] = ["ll": "30.7865,31.0004","limit": "30"]
        client.request(path: "venues/explore", parameter: parameter) { result in
            
            switch result {
            case let .success(data):
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                self.json = json
                
            case let .failure(error):
                switch error {
                case let .connectionError(connectionError):
                    print(connectionError)
                case let .apiError(apiError):
                    print(apiError.errorType)
                    print(apiError.errorDetail)
                }
               
            }
            completed()
        }
        
        }
    
    func completePlaceDetail(){
        if let dic = self.json as? Dictionary<String, AnyObject> {
            if let response = dic["response"] as? Dictionary<String, AnyObject> {
                if let groups = response["groups"] as? [Dictionary<String, AnyObject>] {
                    if let items = groups[0]["items"] as? [Dictionary<String, AnyObject>] {
                        for item in items {
                           let place = Place(placeDetailDic: item)
                            places.append(place)
                        }
                        placeTbl.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as? PlaceCell {
            cell.configPlaceCell(place: places[indexPath.row])
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = places[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: Any?.self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "detailSegue" {
                let detailVC = segue.destination as! DetailVC
                detailVC.place = selectedPlace
            }
        
        }
    

}
