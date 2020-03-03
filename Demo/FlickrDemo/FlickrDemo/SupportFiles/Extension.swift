//
//  Extension.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import Foundation
extension String {
    /**
     String percent encoding
     */
    func percentEncoding() -> String {
        if let string = self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            return string
        }
        return ""
    }
}
