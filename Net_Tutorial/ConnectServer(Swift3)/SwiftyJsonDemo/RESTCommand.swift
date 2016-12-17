//
//  RESTCommand.swift
//  Power
//
//  Created by Rocoo on 2016/11/29.
//  Copyright © 2016年 劉育睿. All rights reserved.
//

import Foundation

class RESTCommand: NSObject{
    var url: String!
    var method: HTTPMethod!
    var parameters: String?
}

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
