//
//  PlaceCell.swift
//  FourSquareTask
//
//  Created by RANDOM on 10/24/17.
//  Copyright © 2017 RANDOM. All rights reserved.
//

import UIKit
import Alamofire

class PlaceCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var placeIcon: UIImageView!
    @IBOutlet weak var distanceLbl: UILabel!
   
    func configPlaceCell(place: Place) {
        name.text = place.name
        distanceLbl.text = "\(place.distance)m"
        Alamofire.download(URL(string: place.imageUrl)!).responseData{ response in
                if let data = response.result.value {
                    print("image Downloded")
                    self.placeIcon.image = UIImage(data: data)
        }
        }
        /*
        let url = URL(string: place.imageUrl)
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url!)
                DispatchQueue.global().async {
                    self.placeIcon.image = UIImage(data: data)
                }
            }catch {
                // handel Error
            }
        }
*/
    }
    
    
    
/*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
*/
    
}
