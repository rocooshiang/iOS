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
    static func fetchSomeDataByGet(){
        ConnectionTask.fetchGetDataWithCallback(url: url) { (json, response, error) in
            if let json = json{
                print("json: \(json)")
            }else{
                print("fetchGetDataWithCallback fail: \(response?.statusCode)")
            }
        }
    }
    
    static func fetchSomeDataByPost(){
        ConnectionTask.fetchPostDataWithCallback(url: url, parameters: nil) { (json, response, error) in
            if let json = json{
                print("json: \(json)")
            }else{
                print("fetchPostDataWithCallback fail: \(response?.statusCode)")
            }
        }
    }
    
    static func someData(withParameters parameters: Parameters?, callback: @escaping (_ json: JSON?, _ statusCode: Int?) -> Void){
        ConnectionTask.fetchDataWithAlamofire(url: url, parameters: parameters) { (json, response, error) in
            if let json = json, let response = response, response.statusCode == connectionSuccess{
                callback(json, nil)
            }else{
                let error = HttpErrorUtilies.dealWithHttpError(statusCode: error?._code)
                callback(nil, error._code)
            }
        }
    }

}
