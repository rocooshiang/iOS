//
//  ProtocolRESTTests.swift
//  ProtocolRESTTests
//
//  Created by Rocoo on 2017/5/22.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import XCTest
@testable import ProtocolREST

class ProtocolRESTTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testPostRequest() {
    let client = LocalFileClient()
    client.send(PostRequest(foodLogId: 6584, comment: "Test by Rocoo")) {
      result in
      XCTAssertNotNil(result,"result is nil")
      XCTAssertEqual(result!.statusCode, 200)      
    }
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

// Testing function
extension ProtocolRESTTests{
  
  struct LocalFileClient: Client {
    func send<T : Request>(_ r: T, handler: @escaping (T.Response?) -> Void) {
      switch r.host {
      case "https://svcapi.prenetics.com":
        
        if r.path != "/v1/FoodLogComment"{
          fatalError("Unknow path")
        }
        
        guard let fileURL = Bundle(for: ProtocolRESTTests.self).url(forResource: "test", withExtension: "") else {
          fatalError()
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
          fatalError()
        }
        
        handler(T.Response.parse(data: data))
        
      default:
        fatalError("Unknown host")
      }
    }
    
  }
  
}
