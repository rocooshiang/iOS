//
//  OnboardingUserInfo.swift
//  ProtocolREST
//
//  Created by Rocoo on 04/01/2018.
//  Copyright © 2018 rocoo. All rights reserved.
//

import Foundation

struct OnboardingUserInfo{
  
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

extension OnboardingUserInfo: Decodable {
  static func parse(data: Data) -> OnboardingUserInfo? {
    return OnboardingUserInfo(data: data)
  }
}
