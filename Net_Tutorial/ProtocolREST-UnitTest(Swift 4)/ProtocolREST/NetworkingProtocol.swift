//
//  NetworkingProtocol.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/22.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation

enum HttpMethod: String {
  case get
  case post
  case delete
  case put
}

enum HttpHeaderField: String{
    case contentType = "Content-Type"
    case accept = "Accept"
    case authorization = "Authorization"
}

enum HttpHeaderValue: String{
    case json = "application/json"
    case urlencoded_utf8 = "application/x-www-form-urlencoded; charset=utf-8"
    case bearerToken = "Bearer X2YTcQ5d5NDRgVSqApdD3tihOiBt8hil0utgb9SBPHuWBlwfWz1Ay152ys9k"
}

protocol Request {
  var header: [HttpHeaderField: HttpHeaderValue] { get }
  var host: String { get }
  var path: String { get }
  var method: HttpMethod { get }
  var parameter: [String: Any]? { get }
  var enableJSONParameters: Bool { get }
  var logResponseData: Bool { get}
  
  associatedtype Response: Decodable
}

extension Request{
  
  var header: [HttpHeaderField: HttpHeaderValue]{
    return [:]
  }
  
  var parameter: [String: Any]?{
    return nil
  }
  
  var enableJSONParameters: Bool{
    return false
  }
  
  var logResponseData: Bool{
    return false
  }
  
  
}

protocol Client {
  func send<T: Request>(_ source: T, handler: @escaping (T.Response?, _ response: HTTPURLResponse?) -> Void)
}

protocol Decodable {
  static func parse(data: Data) -> Self?
}

struct NetworkTaskClient: Client {
  
  static let shared = NetworkTaskClient()
  
  func send<T: Request>(_ source: T, handler: @escaping (T.Response?, _ response: HTTPURLResponse?) -> Void) {
    
    let url = URL(string: source.host.appending(source.path))!
    var request = URLRequest(url: url)
    
    request.httpMethod = source.method.rawValue
    request.timeoutInterval = 30
    
    for (field, value) in source.header{
      request.setValue(value.rawValue, forHTTPHeaderField: field.rawValue)
    }
    
    if let parameter = source.parameter{
      if source.enableJSONParameters{
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
        }
      }else{
        request.httpBody = query(parameter).data(using: .utf8, allowLossyConversion: false)
      }
    }
    
    
    let task = URLSession.shared.dataTask(with: request) {
      data, response, error in

      if let data = data, let res = T.Response.parse(data: data) {
        
        if source.logResponseData{
          print(String(data: data, encoding: .utf8) ?? "response data is nil" )
        }
        
        DispatchQueue.main.async { handler(res, response as? HTTPURLResponse) }
      } else {
        DispatchQueue.main.async { handler(nil, response as? HTTPURLResponse) }
      }
      
    }
    
    task.resume()
  }
  
}



private func query(_ parameters: [String: Any]) -> String {
  var components: [(String, String)] = []
  
  for key in parameters.keys.sorted(by: <) {
    let value = parameters[key]!
    components += queryComponents(fromKey: key, value: value)
  }
  
  return components.map { "\($0)=\($1)" }.joined(separator: "&")
}

public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
  var components: [(String, String)] = []
  
  if let dictionary = value as? [String: Any] {
    for (nestedKey, value) in dictionary {
      components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
    }
  } else if let array = value as? [Any] {
    for value in array {
      components += queryComponents(fromKey: "\(key)[]", value: value)
    }
  } else if let value = value as? NSNumber {
    if value.isBool {
      components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
    } else {
      components.append((escape(key), escape("\(value)")))
    }
  } else if let bool = value as? Bool {
    components.append((escape(key), escape((bool ? "1" : "0"))))
  } else {
    components.append((escape(key), escape("\(value)")))
  }
  
  return components
}

public func escape(_ string: String) -> String {
  let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
  let subDelimitersToEncode = "!$&'()*+,;="
  
  var allowedCharacterSet = CharacterSet.urlQueryAllowed
  allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
  
  var escaped = ""
  
  if #available(iOS 8.3, *) {
    escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
  } else {
    let batchSize = 50
    var index = string.startIndex
    
    while index != string.endIndex {
      let startIndex = index
      let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
      let range = startIndex..<endIndex
      
      let substring = string.substring(with: range)
      
      escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? substring
      
      index = endIndex
    }
  }
  
  return escaped
}

extension NSNumber {
  fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}


