//
//  FetchDataTask.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/10.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FetchDataTask{
  
  static func sampleGet(callback: @escaping (_ json: JSON?, _ response: HTTPURLResponse?) -> Void){
    ConnectionTask.fetchDataWithCallback(command: UserRESTCommand.testingGet()) { (data, response) in
      if let data = data{
        let str = String(data: data, encoding: String.Encoding.utf8)
        callback(JSON(str), response)
      }else{
        HttpErrorUtilies.dealWithHttpError(statusCode: response?.statusCode, errorTitle: nil)
        callback(nil, response)
      }
      
    }
  }
  
  static func samplePost(callback: @escaping (_ json: JSON?, _ response: HTTPURLResponse?) -> Void){
    ConnectionTask.fetchDataWithCallback(command: UserRESTCommand.testingPost()) { (data, response) in
      if let data = data{
        let str = String(data: data, encoding: String.Encoding.utf8)
        callback(JSON(str), response)
      }else{
        HttpErrorUtilies.dealWithHttpError(statusCode: response?.statusCode, errorTitle: nil)
        callback(nil, response)
      }      
    }
  }


}
