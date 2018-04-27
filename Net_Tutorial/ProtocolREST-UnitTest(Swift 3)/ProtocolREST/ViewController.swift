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
    
/*** disable json format ***/
    executeGet()
//    executePost()
    
/*** enable json format ***/
//    executePut()
//    executeDelete()
    
  }
  
}

extension ViewController{
  func executeGet(){
    let request = GetRequest(model: GetModel(firstname: "Rocoo", lastname: "Chuang"))
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Get\" fail")
      }
    }
    
  }
  
  func executePost(){
    let request = PostRequest(model: PostModel(firstname: "Rocoo", lastname: "Chuang"))
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Post\" fail")
      }
    }
  }
  
  
  func executePut(){
    let request = PutRequest(model: PutModel(firstname: "Rocoo", lastname: "Chuang"))
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Put\" fail")
      }
    }
  }
  
  
  func executeDelete(){
    let request = DeleteRequest(model: DeleteModel(firstname: "Rocoo", lastname: "Chuang"))
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Delete\" fail")
      }
    }
  }
}

