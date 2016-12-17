//
//  UserRESTCommand.swift
//  CreateAccount
//
//  Created by Rocoo on 2016/11/24.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

class UserRESTCommand: RESTCommand{
  
  static func commandWithHttp(url: String, method: HTTPMethod, parameters: String?) -> UserRESTCommand{
    let command = UserRESTCommand()
    command.url = url
    command.method = method
    command.parameters = parameters
    return command
  }
  
  static func testingGet() -> UserRESTCommand{
    return commandWithHttp(url: "\(path)/get?account=hello&password=test", method: .get, parameters: nil)
  }
  
  
  static func testingPost() -> UserRESTCommand{
    return commandWithHttp(url: "\(path)/post", method: .get, parameters: "account=hello&password=test")
  }
  
}





