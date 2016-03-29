//
//  Restaurant.swift
//  MapKitDirectionDemo
//
//  Created by Simon Ng on 18/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import Foundation

class Restaurant {
    var name:String = ""
    var category:String = ""
    var address:String = ""
    var image:String = ""
    
    init(name:String, category:String, address:String, image:String) {
    self.name = name
    self.category = category
    self.address = address
    self.image = image
    }
}