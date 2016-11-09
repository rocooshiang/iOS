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

class ViewController: UIViewController {
    
    let url = "https://httpbin.org/post"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        fetchLessonDataByGet()
        //        fetchLessonDataByPost()
        
        
        fetchLessonData(withParameters: nil) { (json, statusCode) in
            if let json = json{
                print("json: \(json)")
            }else{
                print("statusCode: \(statusCode!)")
                self.connectionFailAlert()
            }
        }
        
    }
    
    func fetchLessonDataByGet(){
        fetchGetDataWithCallback(url: url) { (json, response, error) in
            if let json = json{
                print("json: \(json)")
            }else{
                print("fetchLessonDataByGet fail: \(response?.statusCode)")
            }
        }
    }
    
    func fetchLessonDataByPost(){
        fetchPostDataWithCallback(url: url, parameters: nil) { (json, response, error) in
            if let json = json{
                print("json: \(json)")
            }else{
                print("fetchPostDataWithCallback fail: \(response?.statusCode)")
            }
        }
    }
    
    func fetchLessonData(withParameters parameters: Parameters?, callback: @escaping (_ json: JSON?, _ statusCode: Int?) -> Void){
        fetchDataWithAlamofire(url: url, parameters: parameters) { (json, response, error) in
            if let json = json, let response = response, response.statusCode == connectionSuccess{
                callback(json, nil)
            }else{
                let error = HttpErrorUtilies.dealWithHttpError(statusCode: error?._code)
                callback(nil, error._code)
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
    
    func fetchDataWithAlamofire(url: String, parameters: Parameters?, callback: @escaping (_ json: JSON?, _ response: HTTPURLResponse?, _ error: Error?) -> Void){
        
        AlamofireSingleton.sharedInstance.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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


