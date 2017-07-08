//
//  Global.swift
//  PickerView
//
//  Created by Rocoo on 2017/7/8.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation
import UIKit


func colorFromRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
  return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}

struct Device{
  static let screenWidth  = UIScreen.main.bounds.size.width
  static let screenHeight = UIScreen.main.bounds.size.height
  static let maxLength = max(Device.screenWidth, Device.screenHeight)
  static let minLenght = min(Device.screenWidth, Device.screenHeight)
}
