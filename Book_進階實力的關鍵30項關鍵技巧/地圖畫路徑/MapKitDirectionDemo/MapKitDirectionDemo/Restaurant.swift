//
//  Restaurant.swift
//  MapKitDirectionDemo
//
//  Created by Rocoo on 2016/4/22
//  Copyright (c) 2016年 Rocoo. All rights reserved.
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