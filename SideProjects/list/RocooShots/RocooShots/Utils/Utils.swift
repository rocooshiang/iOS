//
//  Utils.swift
//  RocooShots
//
//  Created by Geosat-RD01 on 2016/6/7.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

class Utils{
  class func getStringFromJSON(data: NSDictionary, key: String) -> String{
    
    if let info = data[key] as? String{
      return info
    }
    return ""
  }
}