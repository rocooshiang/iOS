//
//  ViewController.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/7.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

let url = "https://httpbin.org/post"
let connectionSuccess = 200
let timeOut: TimeInterval = 10

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLessonDataByGet()
//        fetchLessonDataByPost()
//        fetchLessonDataByAlamofireGet()
    }
    
    func fetchLessonDataByGet(){
        fetchGetDataWithCallback(url: url) { (json, response, error) in
            if let json = json{
                print("json: \(json)")
                print("origin: \(json["origin"].stringValue)")
                print("url: \(json["url"].stringValue)")
            }else{
                print("fetchLessonDataByGet fail")
            }
        }
    }
    
    func fetchLessonDataByPost(){
        fetchPostDataWithCallback(url: url, parameters: nil) { (json, response, error) in
            if let json = json{
                print("json: \(json)")
                print("origin: \(json["origin"].stringValue)")
                print("url: \(json["url"].stringValue)")
            }else{
                print("fetchPostDataWithCallback fail")
            }
        }
    }
    
    
    func fetchLessonDataByAlamofireGet(){
        
        fetchGetDataWithAlamofire(url: url, parameters: nil) { (json, response, error) in
            if let json = json{
                print("json: \(json)")                
                print("origin: \(json["origin"].stringValue)")
                print("url: \(json["url"].stringValue)")
            }else{
                print("fetchGetDataWithAlamofire fail")
            }
        }
        
    }
    
    
}


extension ViewController{
    
    func fetchGetDataWithCallback(url: String, callback: @escaping (_ json: JSON?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeOut)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest){
            (data, response, error) -> Void in
            
            guard let response = response as? HTTPURLResponse else{
                return callback(nil, nil, error)
            }
            
            if let data = data, response.statusCode == connectionSuccess {
                callback(JSON(data: data), response, nil)
            }else{
                callback(nil, response, error)
            }
            
        }
        task.resume()
    }
    
    func fetchPostDataWithCallback(url: String, parameters: String?, callback: @escaping (_ json: JSON?, _ response: HTTPURLResponse?, _ error: Error?) -> Void){
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeOut)
        request.httpMethod = "POST"
        
        if let parameters = parameters{
            request.httpBody = parameters.data(using: String.Encoding.utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            guard let response = response as? HTTPURLResponse else{
                return callback(nil, nil, error)
            }
            
            if let data = data, response.statusCode == connectionSuccess {
                callback(JSON(data: data), response, nil)
            }else{
                callback(nil, response, error)
            }
            
        }
        task.resume()
    }
    
    func fetchGetDataWithAlamofire(url: String, parameters: String?, callback: @escaping (_ json: JSON?, _ response: HTTPURLResponse?, _ error: Error?) -> Void){

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate { request, response, data in
                
                if let data = data, response.statusCode == connectionSuccess{
                    callback(JSON(data: data), response, nil)
                }
                return .success
            }.responseJSON { response in
                if case let .failure(error) = response.result{
                    callback(nil, nil, error)
                }
        }
    }
    
}

