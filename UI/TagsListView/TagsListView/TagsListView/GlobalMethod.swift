//
//  GlobalMethod.swift
//  TagsListView
//
//  Created by Rocoo on 09/05/2018.
//  Copyright © 2018 rocoo. All rights reserved.
//

import Foundation
import UIKit


public struct Device{
  public static let screenWidth  = UIScreen.main.bounds.size.width
  public static let screenHeight = UIScreen.main.bounds.size.height
  public static let maxLength = max(Device.screenWidth, Device.screenHeight)
  public static let minLenght = min(Device.screenWidth, Device.screenHeight)
}

public struct DeviceType{
  public static let phone4OrLess  = UIDevice.current.userInterfaceIdiom == .phone && Device.maxLength < 568.0
  public static let phone5 = UIDevice.current.userInterfaceIdiom == .phone && Device.maxLength == 568.0
  public static let phone8  = UIDevice.current.userInterfaceIdiom == .phone && Device.maxLength == 667.0
  public static let phone8P = UIDevice.current.userInterfaceIdiom == .phone && Device.maxLength == 736.0
  public static let phoneX = UIDevice.current.userInterfaceIdiom == .phone && Device.maxLength == 812.0
  public static let pad = UIDevice.current.userInterfaceIdiom == .pad && Device.maxLength == 1024.0
}

public extension Int{
  public func rescaleHeightBaseOn5s() -> CGFloat{
    return CGFloat(self) * Device.screenHeight / 568.0
  }
  
  public func rescaleWidthBaseOn5s() -> CGFloat{
    return CGFloat(self) * Device.screenWidth / 320.0
  }
  
  public func rescaleCornerRadius() -> CGFloat{
    return CGFloat(self) * Device.screenWidth / 320.0
  }
  
}



public extension UIColor {
  
  public class func colorFromHEX(hex hexValue: UInt, alpha withAlpha: CGFloat) -> UIColor {
    return UIColor(
      red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(hexValue & 0x0000FF) / 255.0,
      alpha: withAlpha
    )
  }
  
  public class func colorFromHEX(_ rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  public class func colorFromRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
  }
  
  public class func hexStringToUIColor (hex: String) -> UIColor {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
}

