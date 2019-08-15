//
//  NetworkingProtocol.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/22.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation


// About REST
enum HTTPMethod: String {
  case get
  case post
  case delete
  case put
}

protocol Request {
  var host: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameter: [String: Any]? { get }
  var enableJSONFormat: Bool { get }
  
  associatedtype Response: Decodable
}

extension Request{
  
  var parameter: [String: Any]?{
    return nil
  }
  
  var enableJSONFormat: Bool{
    return false
  }
  
}

protocol Client {
  func send<T: Request>(_ r: T, handler: @escaping (T.Response?, _ response: HTTPURLResponse?) -> Void)
}

protocol Decodable {
  static func parse(data: Data) -> Self?
}

struct NetworkTaskClient: Client {
  
  static let shared = NetworkTaskClient()
  
  func send<T: Request>(_ r: T, handler: @escaping (T.Response?, _ response: HTTPURLResponse?) -> Void) {
    
    let url = URL(string: r.host.appending(r.path))!    
    var request = URLRequest(url: url)
    
    request.httpMethod = r.method.rawValue
    request.timeoutInterval = 30
    // TODO: header
    
    if r.enableJSONFormat{
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }else{
      request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
    
    if let parameter = r.parameter{
      if r.enableJSONFormat{
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
        }
      }else{
        request.httpBody = query(parameter).data(using: .utf8, allowLossyConversion: false)
      }
      
      if let data = request.httpBody{
        print("parameters:  \(String(data: data, encoding: .utf8) ?? "string is nil")")
      }
    }
    
    let task = URLSession.shared.dataTask(with: request) {
      data, response, error in
      
      if let d = data{
        print("network response: \(String(data: d, encoding: .utf8) ?? "string is nil")")
      }else{
        print("network response error: \(String(describing: error?.localizedDescription))")
      }
      
      if let data = data, let res = T.Response.parse(data: data) {        
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


