//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Geosat-RD01 on 2016/5/21.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit
import Alamofire




class ViewController: UIViewController {
  
  let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
  
  let parameters = ["account": "hello","password": "test"]
  let getUrlString = "https://httpbin.org/get"
  let postUrlString = "https://httpbin.org/post"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // MARK -  Get (Alamofire), use thread
    dispatch_async(queue) { () -> Void in
      Alamofire.request(.GET, self.getUrlString, parameters: self.parameters).responseString(queue: dispatch_get_main_queue(), encoding: NSUTF8StringEncoding) { (source) in
        
        if source.result.isSuccess{
          print("result1: \(source.result.value!)")
          
        }
      }
    }
    
    
    // MARK - Get (Custom closure)
    fetchGetDataWithCallback(getUrlString) { (data, error) in
      if error == nil{
        
        let result = NSString(data: data!, encoding:
          NSUTF8StringEncoding)!
        print("result2: \(result)")
        
        // Parse json
        do{
          
          let dic1 = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
          let dic2 = dic1?.objectForKey("headers") as? NSDictionary
          if let language = dic2?.objectForKey("Accept-Language") as? String{
            print("language = \(language)")
          }
          
        }catch{
          print("Parse json error: \(error)")
        }
        
      }
    }
    
    
    // MARK - Post (Alamofire)
    Alamofire.request(.POST, postUrlString, parameters: parameters).responseData { (source) in
      if source.result.isSuccess{
        let result = NSString(data: source.data!, encoding:
          NSUTF8StringEncoding)!
        print("result3: \(result)")
        
      }
    }
    
    // MARK - Post (Custom closure)
    fetchPostDataWithCallback(postUrlString, parameters: "account=hello&password=test") { (data, error) in
      if error == nil{
        let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("result4: \(result)")
      }
    }
    
}
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}

// MARK - Custom function
extension ViewController{
  
  func fetchGetDataWithCallback(url: String, callback: (data: NSData? ,error: NSError?) -> Void) {
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request){
      (data, response, error) -> Void in
      
      if error != nil {
        callback(data: nil, error: error)
      } else {
        callback(data: data, error: nil)
      }
    }
    task.resume()
  }
  
  func fetchPostDataWithCallback(url: String,parameters: String, callback: (data: NSData? ,error: NSError?) -> Void){
    
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30)
    request.HTTPMethod = "POST"
    request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
    
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
      data, response, error in
      
      if error != nil {
        callback(data: nil, error: error)
      } else {
        callback(data: data, error: nil)
      }
      
    }
    task.resume();
  }
  
}

