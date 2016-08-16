//
//  MessageContent.swift
//  FirebaseChat
//
//  Created by Geosat-RD01 on 2016/8/16.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

class MessageContent{
  let userName: String
  let message: String
  let time: String
  
  init?(data: NSDictionary){
    guard let userName = data["userName"] as? String else{
      return nil
    }
    guard let message = data["message"] as? String else{
      return nil
    }
    guard let time = data["time"] as? String else{
      return nil
    }
    
    self.userName = userName
    self.message = message
    self.time = time
  }
}