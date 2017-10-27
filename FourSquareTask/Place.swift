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
    private var _checkinsCount: Int!
    private var _usersCount:Int!
    private var _price: String!
    private var _rate: Double!
    private var _likesCount: String!
    private var _isOpen: Bool!
    private var _hours: String!
    
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
            if let stats = venue["stats"] as? Dictionary<String, AnyObject> {
                if let checkinsCount = stats["checkinsCount"] as? Int {
                        self._checkinsCount = checkinsCount
                }
                if let usersCount = stats["usersCount"] as? Int {
                    self._usersCount = usersCount
                }
            }
            if let price = venue["price"] as? Dictionary<String, AnyObject> {
                if let message = price["message"] as? String {
                    self._price = message
                }
            }
            if let rating = venue["rating"] as? Double {
                self._rate = rating
            }
            if let hours = venue["hours"] as? Dictionary<String, AnyObject> {
                if let isOpen = hours["isOpen"] as? Bool {
                    self._isOpen = isOpen
                }
                if let status = hours["status"] as? String {
                    self._hours = status
                }
            }
        }
        if let tips = placeDetailDic["tips"] as? [Dictionary<String,AnyObject>] {
            if let likes = tips[0]["likes"] as? Dictionary<String,AnyObject> {
                if let summary = likes["summary"] as? String {
                    self._likesCount = summary
                }
            }
        }
    }
    
    var id: String {
        if _id == nil {
            _id = ""
        }
        return _id
    }
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    var phone: String {
        if _phone == nil {
            _phone = "-"
        }
        return _phone
    }
    var address: String {
        if _address == nil {
            _address = "-"
        }
        return _address
    }
    var distance: Double {
        if _distance == nil {
            _distance = 0.0
        }
        return _distance
    }
    var category: String {
        if _category == nil {
            _category = "-"
        }
        return _category
    }
    var imageUrl: String {
        if _imageUrl == nil {
            _imageUrl = ""
        }
        return _imageUrl
    }
    var checkinsCount: Int {
        if _checkinsCount == nil {
            _checkinsCount = 0
        }
        return _checkinsCount
    }
    var usersCount: Int {
        if _usersCount == nil {
            _usersCount = 0
        }
        return _usersCount
    }
    var price: String {
        if _price == nil {
            _price = "-"
        }
        return _price
    }
    var rate: Double {
        if _rate == nil {
            _rate = 0.0
        }
        return _rate
    }
    var likesCount: String {
        if _likesCount == nil {
            _likesCount = "-"
        }
        return _likesCount
    }
    var isOpen: Bool {
        if _isOpen == nil {
            _isOpen = false
        }
        return _isOpen
    }
    var hours: String {
        if _hours == nil {
            _hours = "-"
        }
        return _hours
    }
    
}
