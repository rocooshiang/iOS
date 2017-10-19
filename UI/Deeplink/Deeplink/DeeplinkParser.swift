//
//  DeeplinkParser.swift
//  Deeplinks
//
//  Created by Stanislav Ostrovskiy on 5/25/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation

var isDev = false

var url: String{
  return isDev ? "Dev" : "Production"
}

class DeeplinkParser {
    static let shared = DeeplinkParser()
    private init() { }
    
    func parseDeepLink(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return
        }
        
        var pathComponents = components.path.components(separatedBy: "/")

        // the first component is empty
        pathComponents.removeFirst()
        
        switch host {
        case "dev":
          isDev = true
        case "production":
          isDev = false
        default:
            break
        }
    }
}
