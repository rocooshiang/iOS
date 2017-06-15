//
//  Put.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/30.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation

struct Put{
  
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

extension Put: Decodable {
  static func parse(data: Data) -> Put? {
    return Put(data: data)
  }
}
