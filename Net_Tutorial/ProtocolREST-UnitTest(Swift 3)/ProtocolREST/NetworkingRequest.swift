//
//  NetworkingRequest.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/29.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation

struct Url{
  static let baseUrl = "https://httpbin.org"
}

struct GetRequest: Request {
  
  var model: GetModel
  
  let host = Url.baseUrl
  var path: String{
    return String(format: "/get?firstname=%@&lastname=%@", model.firstname, model.lastname)
  }
  
  let method: HTTPMethod = .get
  
  typealias Response = Get
}



struct PostRequest: Request {
  
  var model: PostModel
  
  let host = Url.baseUrl
  var path: String{
    return "/post"
  }
  
  let method: HTTPMethod = .post
  
  var parameter: [String: Any]?{
    return ["firstname": model.firstname,
            "lastname": model.lastname]
  }
  
  typealias Response = Post
}



struct PutRequest: Request {
  
  var model: PutModel
  
  let host = Url.baseUrl
  var path: String{
    return "/put"
  }
  
  let method: HTTPMethod = .put
  
  var parameter: [String: Any]?{
    return ["firstname": model.firstname,
            "lastname": model.lastname]
  }
  
  var enableJSONFormat: Bool{
    return true
  }
  
  typealias Response = Put
}



struct DeleteRequest: Request {
  
  var model: DeleteModel
  
  let host = Url.baseUrl
  var path: String{
    return "/delete"
  }
  
  let method: HTTPMethod = .delete
  
  var parameter: [String: Any]?{
    return ["firstname": model.firstname,
            "lastname": model.lastname]
  }
  
  var enableJSONFormat: Bool{
    return true
  }
  
  typealias Response = Delete
}


