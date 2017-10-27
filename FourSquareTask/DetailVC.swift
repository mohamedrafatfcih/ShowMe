//
//  DetailVC.swift
//  FourSquareTask
//
//  Created by RANDOM on 10/25/17.
//  Copyright © 2017 RANDOM. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var isOpenLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var checkinsLbl: UILabel!
    @IBOutlet weak var usersCountLbl: UILabel!
    
    
    var place: Place!

    override func viewDidLoad() {
        super.viewDidLoad()
        completePlaceDetail()
    }

    func completePlaceDetail(){
        name.text = place.name
        addressLbl.text = "Address: \(place.address)"
        distanceLbl.text = "Distance: \(place.distance)m"
        phoneLbl.text = "Phone: \(place.phone)"
        categoryLbl.text = "Category: \(place.category)"
        priceLbl.text = "Price: \(place.price)"
        hoursLbl.text = "Hours: \(place.hours)"
        likesLbl.text = "Likes: \(place.likesCount)"
        if place.isOpen {
            isOpenLbl.text = "State: Open"
        }else{
            isOpenLbl.text = "State: Closed"
        }
        checkinsLbl.text = "Checkins: \(place.checkinsCount)"
        usersCountLbl.text = "Users: \(place.usersCount)"
        rateLbl.text = "Rate: \(place.rate)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
