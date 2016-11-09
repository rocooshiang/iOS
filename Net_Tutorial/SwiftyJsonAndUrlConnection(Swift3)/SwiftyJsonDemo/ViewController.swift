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

let url = "http://192.168.0.100/powertest_php_1"
let timeOut: TimeInterval = 10
let errorDomain = "TaoG"

let connectionSuccess = 200

let errorNetwork = -1009
let errorTimeout = -1001

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        fetchLessonDataByGet()
        //        fetchLessonDataByPost()
        fetchLessonDataByAlamofire(withParameters: nil) // [String: Any]
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
    
    func fetchLessonDataByAlamofire(withParameters parameters: Parameters?){
        fetchDataWithAlamofire(url: url, parameters: parameters) { (json, response, error) in
            if let json = json, let response = response, response.statusCode == connectionSuccess{
                print("json: \(json)")
            }else{
                print("fetchDataWithAlamofire fail: \(error?._code)")
                let error = self.dealWithHttpError(statusCode: error?._code)
                print("Error code: \(error._code)")
            
            }
        }
    }
    
    func dealWithHttpError(statusCode code: Int?) -> NSError{
        guard let code = code else{
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        }
        
        switch code {
        case errorTimeout:
            return NSError(domain: errorDomain, code: errorTimeout, userInfo: nil)
        case errorNetwork:
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        default:
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
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


class AlamofireSingleton{
    static let sharedInstance: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = timeOut
        configuration.timeoutIntervalForRequest = timeOut
        return Alamofire.SessionManager(configuration: configuration)
    }()
}

