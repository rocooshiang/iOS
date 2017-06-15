//
//  NetworkingRequest.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/29.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation


/*** Get ***/
struct GetRequest: Request {
  
  var name: String
  var message: String
  
  let host = "https://httpbin.org"
  var path: String{
    return "/get?name=\(name)&message=\(message)"
  }
  
  let method: HTTPMethod = .GET
  
  let parameter: [String: Any]? = nil
  
  typealias Response = Get
}


/*** Post ***/
struct PostRequest: Request {
  
  var foodLogId: Int
  var comment: String
  
  private let uid = "1496045563.15434"
  private let serviceAccount = "80aac9415b5247569ba10db81dca3006fa34300398bfd61d7644998c014304c2"
  private let tokenId = "769005d3f648e3904a7988454aea9029feaaceda08a73410ef77b97ee3323d6d"
  
  let host = "https://svcapi.prenetics.com"
  var path: String{
    return "/v1/FoodLogComment"
  }
  
  let method: HTTPMethod = .POST
  
  var parameter: [String: Any]?{
    return ["foodLogId": foodLogId,
            "comment": comment,
            "uid": uid,
            "serviceAccount": serviceAccount,
            "tokenId": tokenId]
  }
  
  typealias Response = Post
}


/*** PUT ***/
struct PutRequest: Request {
  
  var nickName: String
  
  private let uid = "1496045563.15434"
  private let serviceAccount = "80aac9415b5247569ba10db81dca3006fa34300398bfd61d7644998c014304c2"
  private let tokenId = "769005d3f648e3904a7988454aea9029feaaceda08a73410ef77b97ee3323d6d"
  
  let host = "https://svcapi.prenetics.com"
  var path: String{
    return "/v1/Profile"
  }
  
  let method: HTTPMethod = .PUT
  
  var parameter: [String: Any]?{
    return ["nickName": nickName,
            "uid": uid,
            "serviceAccount": serviceAccount,
            "tokenId": tokenId]
  }
  
  typealias Response = Put
}


/*** DELETE ***/
struct DeleteRequest: Request {
  
  var foodLogId: Int
  
  private let uid = "1496045563.15434"
  private let serviceAccount = "80aac9415b5247569ba10db81dca3006fa34300398bfd61d7644998c014304c2"
  private let tokenId = "769005d3f648e3904a7988454aea9029feaaceda08a73410ef77b97ee3323d6d"
  
  let host = "https://svcapi.prenetics.com"
  var path: String{
    return "/v1/FoodLog"
  }
  
  let method: HTTPMethod = .DELETE
  
  var parameter: [String: Any]?{
    return ["foodLogId": foodLogId,
            "uid": uid,
            "serviceAccount": serviceAccount,
            "tokenId": tokenId]
  }
  
  typealias Response = Delete
}


