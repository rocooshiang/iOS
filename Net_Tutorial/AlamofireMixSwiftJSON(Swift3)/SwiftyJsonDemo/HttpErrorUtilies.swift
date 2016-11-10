//
//  HttpErrorUtilies.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/9.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

var connectionFailMessage = "Not connection fail message."

class HttpErrorUtilies{
    static func dealWithHttpError(statusCode code: Int?) -> NSError{
        guard let code = code else{
            connectionFailMessage = "Connection network error."
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        }
        
        switch code {
        case errorTimeout:
            connectionFailMessage = "Connection time out."
            return NSError(domain: errorDomain, code: errorTimeout, userInfo: nil)
        case errorNetwork:
            connectionFailMessage = "Connection network error."
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        default:
            connectionFailMessage = "Connection network error."
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        }
    }
    
}


 
