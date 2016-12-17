//
//  ConnectionTask.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/10.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ConnectionTask{
  
  static func fetchDataWithCallback(command: RESTCommand, callback: @escaping (_ data: Data?, _ response: HTTPURLResponse?) -> Void){
    
    let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: command.url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeOut)
    
    request.httpMethod = command.method.rawValue
    
    if let parameters = command.parameters{
      request.httpBody = parameters.data(using: String.Encoding.utf8)
    }
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
      data, response, error in
      
      guard let response = response as? HTTPURLResponse else{
        return callback(nil, nil)
      }
      
      callback(data, response)
    }
    task.resume()
  }
  
    static func fetchDataWithAlamofire(url: String, parameters: Parameters?, callback: @escaping (_ json: JSON?, _ response: HTTPURLResponse?, _ error: Error?) -> Void){
        
        AlamofireSingleton.sharedInstance.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate { request, response, data in
            
            
            print("statusCode: \(response.statusCode)")
            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("str: \(str)")
                
            return .success
            }
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    callback(JSON(json), response.response, nil)
                case .failure(let error):
                    callback(nil, response.response, error)
                }
        }
    }

}
