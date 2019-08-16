//
//  Post.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/29.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PostModel {
  let firstname: String
  let lastname: String
}

struct Post {
  
  let firstname: String
  let lastname: String
  
  init?(data: Data) {
    let json = JSON(data)
    let firstname = json["form"]["firstname"].stringValue
    let lastname = json["form"]["lastname"].stringValue
    self.firstname = firstname
    self.lastname = lastname
  }
  
}

extension Post: Decodable {
  static func parse(data: Data) -> Post? {
    return Post(data: data)
  }
}
