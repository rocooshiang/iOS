//
//  Post.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/29.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation

struct Post {
  
  let statusCode: Int
  let statusMessage: String
  
  init?(data: Data) {
    
    guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
      return nil
    }
    
    guard let statusCode = obj?["statusCode"] as? Int else {
      return nil
    }
    
    guard let statusMessage = obj?["statusMessage"] as? String else {
      return nil
    }
    
    self.statusCode = statusCode
    self.statusMessage = statusMessage
  }
}

extension Post: Decodable {
  static func parse(data: Data) -> Post? {
    return Post(data: data)
  }
}
