//
//  Place.swift
//  FourSquareTask
//
//  Created by RANDOM on 10/24/17.
//  Copyright © 2017 RANDOM. All rights reserved.
//

import Foundation

class Place {
    private var _id: String!
    private var _name: String!
    private var _phone: String!
    private var _address: String!
    private var _distance: Double!
    private var _category: String!
    private var _imageUrl: String!
    
    
    /*init(id: String, name: String, phone:String, address: String, distance: Double, category: String) {
        self._id = id
        self._name = name
        self._phone = phone
        self._address = address
        self._distance = distance
        self._category = category
        
    }*/
    
    init(placeDetailDic: Dictionary<String,AnyObject>) {
        if let venue = placeDetailDic["venue"] as? Dictionary<String, AnyObject> {
            if let veneuId = venue["id"] as? String {
                self._id = veneuId
            }
            if let name = venue["name"] as? String {
                self._name = name.capitalized
              //  print(self._name)
            }
            if let contact = venue["contact"] as? Dictionary<String, AnyObject> {
                if let phoneNum = contact["phone"] as? String {
                    self._phone = phoneNum
                }
            }
            if let location = venue["location"] as? Dictionary<String, AnyObject> {
                if let addr = location["address"] as? String {
                    self._address = addr.capitalized
                }
                if let distance = location["distance"] as? Double {
                    self._distance = distance
                }
            }
            if let categories = venue["categories"] as? [Dictionary<String,AnyObject>] {
                if let category = categories[0]["name"] as? String {
                    self._category = category.capitalized
                }
                if let icon = categories[0]["icon"] as? Dictionary<String, AnyObject> {
                    if let prefix = icon["prefix"] as? String {
                        self._imageUrl = prefix
                    }
                    if let suffix = icon["suffix"] as? String {
                        self._imageUrl = "\(self._imageUrl!)bg_64\(suffix)"
                    }
                }
            }
        }
    }
    
    var id: String {
        return _id
    }
    var name: String {
        return _name
    }
    var phone: String {
        return _phone
    }
    var address: String {
        return _address
    }
    var distance: Double {
        return _distance
    }
    var category: String {
        return _category
    }
    var imageUrl: String {
        return _imageUrl
    }
    
}
