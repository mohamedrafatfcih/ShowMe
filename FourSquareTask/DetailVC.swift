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
    
    var place: Place!

    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = place.name
        
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
