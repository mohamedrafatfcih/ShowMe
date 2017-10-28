//
//  PlaceTableVC.swift
//  FourSquareTask
//
//  Created by RANDOM on 10/24/17.
//  Copyright © 2017 RANDOM. All rights reserved.
//

import UIKit
import FoursquareAPIClient
import CoreLocation

typealias DownloadComplete = () -> ()

class PlaceTableVC: UITableViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var locationIsReady = false
    @IBOutlet var placeTbl: UITableView!
    var places = [Place]()
    var selectedPlace: Place!
    let client = FoursquareAPIClient(clientId:"CZPVCRCL3J4W4ZY2SDB0XD4OURPW0J4VKL54UPQY50HYQ5EK", clientSecret:"M2TJMFYIVVDUVSVQGVEZ3M2FWN3AIASI3E2LKFXEXB0YMOZ5", version: "20170801")
     var json: Any!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        placeTbl.delegate = self
        placeTbl.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            manager.stopUpdatingLocation()
        Location.sharedInstance.latitude = myLocation.latitude
        Location.sharedInstance.longitude = myLocation.longitude
        print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        // getting Places Info
        exploreVenues {
            self.completePlaceDetail()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

    
    func exploreVenues(completed: @escaping DownloadComplete){
        let parameter: [String: String] = ["ll": "\(Location.sharedInstance.latitude!), \(Location.sharedInstance.longitude!)","limit": "20"]
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
        performSegue(withIdentifier: "detailSegue", sender: places[indexPath.row])
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
                if let place = sender as? Place {
                    detailVC.place = place
                }
            }
        
        }
    

}
