//
//  User.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/22.
//  Copyright © 2017年 rocoo. All rights reserved.
//


import Foundation

struct Get {
  
  let ip: String
  
  init?(data: Data) {
    
    guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
      return nil
    }
    
    guard let ip = obj?["origin"] as? String else {
      return nil
    }
    
    self.ip = ip
  }
  
}

extension Get: Decodable {
  static func parse(data: Data) -> Get? {
    return Get(data: data)
  }
}



