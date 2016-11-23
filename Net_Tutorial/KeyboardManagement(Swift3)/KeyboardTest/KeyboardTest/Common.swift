//
//  Common.swift
//  KeyboardTest
//
//  Created by Rocoo on 2016/11/23.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation
import UIKit

struct device{
    static let screenWidth  = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}


func colorFromRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}
