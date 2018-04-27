//
//  Delete.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/30.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DeleteModel {
  let firstname: String
  let lastname: String
}

struct Delete{
  let firstname: String
  let lastname: String
  
  init?(data: Data) {
    let json = JSON(data)
    let firstname = json["json"]["firstname"].stringValue
    let lastname = json["json"]["lastname"].stringValue
    self.firstname = firstname
    self.lastname = lastname
  }
  
}

extension Delete: Decodable {
  static func parse(data: Data) -> Delete? {
    return Delete(data: data)
  }
}
