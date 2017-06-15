//
//  ViewController.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/22.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /*** Server connection with protocol ***/
//    executeGet()
//    executePost()
//    executePut()
//    executeDelete()
    

    
    /*** UserDefault store enum ***/
    
    // Store Temperature Notation
    UserDefaults.set(temperatureNotation: .celsius)
    
    // Fetch Temperature Notation
    let type = UserDefaults.temperatureNotation
    
  }
  
  func executeGet(){
    URLSessionClient().send(GetRequest(name: "Rocoo", message: "Hi~")) { result in
      print("GET -------------------- GET ------------------------- GET")
      
      if let result = result {
        print("ip: \(result.ip)")
      }else{
        print("fail")
      }
    }
  }

  func executePost(){
    URLSessionClient().send(PostRequest(foodLogId: 6584, comment: "你好!!")) { result in
      print("POST -------------------- POST ------------------------- POST")
      
      if let result = result {
        print("statusCode: \(result.statusCode), statusMessage: \(result.statusCode)")
      }else{
        print("fail")
      }
    }
  }
  
  func executePut(){
    URLSessionClient().send(PutRequest(nickName: "Rocoo Rocoo")) { result in
      print("PUT -------------------- PUT ------------------------- PUT")
      
      if let result = result {
        print("statusCode: \(result.statusCode), statusMessage: \(result.statusMessage)")
      }else{
        print("fail")
      }
    }
  }
  
  func executeDelete(){
    URLSessionClient().send(DeleteRequest(foodLogId: 7089)) { result in
      print("DELETE -------------------- DELETE ------------------------- DELETE")
      
      if let result = result {
        print("statusCode: \(result.statusCode), statusMessage: \(result.statusMessage)")
      }else{
        print("fail")
      }
    }
  }
  
}

