//
//  Extension.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/21.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import UIKit

let defaultViewImage = "default".image()

extension UITableViewCell {
    // Generated cell identifier derived from class name
    func cellIdentifier() -> String {
        return String(describing: self)
    }
}
