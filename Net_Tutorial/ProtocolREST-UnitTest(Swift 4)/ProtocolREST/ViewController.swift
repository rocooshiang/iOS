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
//    executeGet()
//    executePost()
    
/*** enable json format ***/
//    executePut()
//    executeDelete()
  
    fetchRooms()
    
  }
  
}

extension ViewController{
  func executeGet(){
    let request = GetRequest(model: GetRequestModel(firstname: "Rocoo", lastname: "Chuang"))
    
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Get\" fail")
      }
    }
    
  }
  
  func executePost(){
    let request = PostRequest(model: PostRequestModel(firstname: "Rocoo", lastname: "Chuang"))
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Post\" fail")
      }
    }
  }
  
  
  func executePut(){
    let request = PutRequest(model: PutRequestModel(firstname: "Rocoo", lastname: "Chuang"))
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Put\" fail")
      }
    }
  }
  
  
  func executeDelete(){
    let request = DeleteRequest(model: DeleteRequestModel(firstname: "Rocoo", lastname: "Chuang"))
    
    NetworkTaskClient.shared.send(request) { (result, response) in
      if let result = result, response?.statusCode == 200{
        print("firstname: \(result.firstname), lastname: \(result.lastname)")
      }else{
        print("request \"Delete\" fail")
      }
    }
  }
  
  func fetchRooms(){    
    let request = RoomsRequest()
    NetworkTaskClient.shared.send(request) { (result, response) in      
      if let result = result, response?.statusCode == 200{
        for room in result.rooms{
          print("room name: \(room.name)")
        }
      }else{
        print("fetch rooms fail")
      }
    }
  }
}

