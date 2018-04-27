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
    
    client.send(PostRequest(model: PostModel(firstname: "Rocoo", lastname: "Chuang"))) {
      result in
      XCTAssertNotNil(result,"result is nil")
      XCTAssertNotNil(result.0, "PostRequest.Response is nil")
      XCTAssertEqual(result.0!.firstname, "Rocoo")
      XCTAssertEqual(result.0!.lastname, "Chuang")      
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
    
    func send<T : Request>(_ r: T, handler: @escaping (T.Response?, HTTPURLResponse?) -> Void) {
      switch r.host {
      case Url.baseUrl:
        
        if r.path != "/post"{
          fatalError("Unknow path")
        }
        
        guard let fileURL = Bundle(for: ProtocolRESTTests.self).url(forResource: "test", withExtension: "") else {
          fatalError()
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
          fatalError()
        }
        
        
        handler(T.Response.parse(data: data), HTTPURLResponse())
        
      default:
        fatalError("Unknown host")
      }
    }
    
  }
  
}
