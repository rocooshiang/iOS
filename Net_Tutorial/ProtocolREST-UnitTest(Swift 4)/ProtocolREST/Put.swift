//
//  Put.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/30.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PutRequestModel {
  let firstname: String
  let lastname: String
}

struct Put {
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

extension Put: Decodable {
  static func parse(data: Data) -> Put? {
    return Put(data: data)
  }
}
