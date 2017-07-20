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


extension Int{
  func rescaleFontSize() -> CGFloat{
    if UIDevice.current.userInterfaceIdiom == .phone{
      switch Device.maxLength {
      case 568.0:
        return CGFloat(self) - 3
      case 667.0:
        return CGFloat(self)
      case 736.0:
        return CGFloat(self) + 2
      default:
        return CGFloat(self)
      }
    }
    return CGFloat(self)
  }
  
  
  func rescaleByDeviceHeight() -> CGFloat{
    return CGFloat(self) * Device.screenHeight / 667.0
  }
  
  func rescaleByDeviceWidth() -> CGFloat{
    return CGFloat(self) * Device.screenWidth / 375.0
  }
}
