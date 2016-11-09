//
//  Singleton.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/9.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireSingleton{
    static let sharedInstance: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = timeOut
        configuration.timeoutIntervalForRequest = timeOut
        return Alamofire.SessionManager(configuration: configuration)
    }()
}
