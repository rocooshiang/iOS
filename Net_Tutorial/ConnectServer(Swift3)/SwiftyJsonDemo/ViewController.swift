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
  
  var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //------------------------
    // @ Get Get Get
    //------------------------
    FetchDataTask.sampleGet { (json, response) in
      if let json = json{
        print("json: \(json)")
      }else{
        self.connectionFailAlert()
      }
    }    
    
    //------------------------
    // @ Post Post Post
    //------------------------
    FetchDataTask.samplePost { (json, response) in
      if let json = json{
        print("post json: \(json)")
      }else{
        self.connectionFailAlert()
      }
    }
    
  }
  
}


