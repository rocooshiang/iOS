//
//  DribbbleAPI.swift
//  RocooShots
//
//  Created by Geosat-RD01 on 2016/6/7.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

class DribbbleAPI{
  
  let accessToken = "cb404a5b8f4b3d4cdba61354e2491a0ac374f2c8685b75291d66de658a11e7eb"
  func loadShots(completion: (([Shot]) -> Void)!) {
    
    let urlString = "https://api.dribbble.com/v1/shots?access_token=\(accessToken)"
    
    let session = NSURLSession.sharedSession()
    let shotsUrl = NSURL(string: urlString)
    
    let task = session.dataTaskWithURL(shotsUrl!) { (data, response, error) in
      if error != nil{
        print(error?.localizedDescription)
      }else{
        
        do{
          
          let shotsData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
          var shots = [Shot]()
          
          for shot in shotsData{
            let shot = Shot(data: shot as! NSDictionary)
            shots.append(shot)
          }
         
          let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
          dispatch_async(dispatch_get_global_queue(priority, 0)){
            
            completion(shots)
          }
          
        }catch let error as NSError{
          print("Json parser error: \(error.localizedDescription)")
        }
      }
    }
    task.resume()
  }
  
}