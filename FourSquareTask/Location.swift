//
//  Location.swift
//  WetherApp
//
//  Created by RANDOM on 10/17/17.
//  Copyright © 2017 RANDOM. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
}

