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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        FetchDataTask.fetchSomeDataByGet()
//        FetchDataTask.fetchSomeDataByPost()
        
        FetchDataTask.someData(withParameters: nil) { (json, statusCode) in
            if let json = json{
                print("json: \(json)")
                
                let headers = json["headers"]
                print("agent: \(headers["User-Agent"].stringValue)")
                print("host: \(headers["Host"].stringValue)")
                
                print("origin: \(json["origin"].stringValue)")
                print("url: \(json["url"].stringValue)")
                
            }else{
                print("statusCode: \(statusCode!)")
                self.connectionFailAlert()
            }
        }
    }
    
}


