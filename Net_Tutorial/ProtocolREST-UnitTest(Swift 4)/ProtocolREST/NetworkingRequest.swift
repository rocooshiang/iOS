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
  static let hotelBaseUrl = "https://challenge.thef2e.com"
}

struct GetRequest: Request {
  
  var model: GetRequestModel
  let host = Url.baseUrl
  var path: String{
    return String(format: "/get?firstname=%@&lastname=%@", model.firstname, model.lastname)
  }
  
  let method: HttpMethod = .get
  
  
  typealias Response = Get
}



struct PostRequest: Request {
  
  var model: PostRequestModel
  var header: [HttpHeaderField: HttpHeaderValue]{
    return [.contentType: .json]
  }
  
  let host = Url.baseUrl
  var path: String{
    return "/post"
  }
  
  let method: HttpMethod = .post
  
  var parameter: [String: Any]?{
    return ["firstname": model.firstname,
            "lastname": model.lastname]
  }
  
  typealias Response = Post
}



struct PutRequest: Request {
  
  var model: PutRequestModel
  
  let host = Url.baseUrl
  var path: String{
    return "/put"
  }
  
  let method: HttpMethod = .put
  
  var parameter: [String: Any]?{
    return ["firstname": model.firstname,
            "lastname": model.lastname]
  }
  
  var enableJSONParameters: Bool{
    return true
  }
  
  typealias Response = Put
}



struct DeleteRequest: Request {
  
  var model: DeleteRequestModel
  
  let host = Url.baseUrl
  var path: String{
    return "/delete"
  }
  
  let method: HttpMethod = .delete
  
  var parameter: [String: Any]?{
    return ["firstname": model.firstname,
            "lastname": model.lastname]
  }
  
  var enableJSONParameters: Bool{
    return true
  }
  
  typealias Response = Delete
}


// https://challenge.thef2e.com/news/17
struct RoomsRequest: Request {
  
  var host: String{
    return Url.hotelBaseUrl
  }
  
  var path: String{
    return "/api/thef2e2019/stage6/rooms"
  }
  
  var header: [HttpHeaderField: HttpHeaderValue]{
    return [.accept: .json,
            .authorization: .bearerToken]
  }
  
  let method: HttpMethod = .get
  
  var logResponseData: Bool{
    return true
  }
  
  typealias Response = Rooms
}
