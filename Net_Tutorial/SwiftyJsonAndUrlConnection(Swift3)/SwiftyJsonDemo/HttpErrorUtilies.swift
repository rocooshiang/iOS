//
//  HttpErrorUtilies.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/9.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

class HttpErrorUtilies{
    static func dealWithHttpError(statusCode code: Int?) -> NSError{
        guard let code = code else{
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        }
        
        switch code {
        case errorTimeout:
            return NSError(domain: errorDomain, code: errorTimeout, userInfo: nil)
        case errorNetwork:
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        default:
            return NSError(domain: errorDomain, code: errorNetwork, userInfo: nil)
        }
    }

}
