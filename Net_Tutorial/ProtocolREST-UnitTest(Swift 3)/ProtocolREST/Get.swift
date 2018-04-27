//
//  User.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/22.
//  Copyright © 2017年 rocoo. All rights reserved.
//


import Foundation
import SwiftyJSON

struct GetModel {
  let firstname: String
  let lastname: String
}

struct Get {
  
  let firstname: String
  let lastname: String
  
  init?(data: Data) {
    let json = JSON(data)
    let firstname = json["args"]["firstname"].stringValue
    let lastname = json["args"]["lastname"].stringValue
    self.firstname = firstname
    self.lastname = lastname
  }
  
}

extension Get: Decodable {
  static func parse(data: Data) -> Get? {
    return Get(data: data)
  }
}



