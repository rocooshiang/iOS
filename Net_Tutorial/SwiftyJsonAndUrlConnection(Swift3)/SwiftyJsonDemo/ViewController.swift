//
//  ViewController.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/7.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit
import SwiftyJSON

let url = ""
let connectionSuccess = 200
let timeOut: TimeInterval = 10

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchLessonDataByGet()
        fetchLessonDataByPost()
    }
    
    func fetchLessonDataByGet(){
        fetchGetDataWithCallback(url: url) { (json, response, error) in
            if let json = json, let response = response, response.statusCode == connectionSuccess {
                print("Success: \(json.string)")
                // Parse json
            }else{
                print("fail: \(error)")
            }
        }
    }
    
    func fetchLessonDataByPost(){
        fetchPostDataWithCallback(url: url, parameters: nil) { (json, response, error) in
            if let json = json, let response = response, response.statusCode == connectionSuccess {
                print("Success: \(json.string)")
                // Parse json
            }else{
                print("fail: \(error)")
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
            
            if let data = data{
                callback(JSON(data), response, nil)
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
            
            if let data = data{
                callback(JSON(data), response, nil)
            }else{
                callback(nil, response, error)
            }
            
        }
        task.resume()
    }
    
}

