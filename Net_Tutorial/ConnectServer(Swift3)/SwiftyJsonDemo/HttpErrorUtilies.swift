//
//  HttpErrorUtilies.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/9.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

var connectionFailTitle = "Not connection fail title"
var connectionFailMessage = "Not connection fail message"

class HttpErrorUtilies{
  static func dealWithHttpError(statusCode code: Int?, errorTitle title: String?){
    guard let code = code else{
      connectionFailTitle = "Connection network error"
      connectionFailMessage = "Please check your internet and try it again."
      return
    }
    
    switch code {
    case errorTimeout:
      connectionFailTitle = "Connection time out"
      connectionFailMessage = "Please check your internet and try it again."
    case errorNetwork:
      connectionFailTitle = "Connection network error"
      connectionFailMessage = "Please check your internet and try it again."
    default:
      connectionFailTitle = "Connection network error"
      connectionFailMessage = "Please check your internet and try it again."
    }
  }
  
}



