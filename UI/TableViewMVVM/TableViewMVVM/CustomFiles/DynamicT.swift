//
//  DynamicT.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/15.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

class Dynamic<T> {

    var bind :(T) -> Void = { _ in }

    var value :T? {
        didSet {
            bind(value!)
        }
    }

    init(_ newValue :T) {
        value = newValue
    }

}
