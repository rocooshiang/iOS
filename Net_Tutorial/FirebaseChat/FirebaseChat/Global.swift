//
//  Global.swift
//  FirebaseChat
//
//  Created by Geosat-RD01 on 2016/8/16.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
  
  func showAlert(title: String, message: String?, buttonText: String) {
    
    let controller  = UIAlertController(title: title, message: message ?? nil, preferredStyle: .Alert)
    let action = UIAlertAction(title: buttonText, style: .Default, handler: nil)
    controller.addAction(action)    
    self.presentViewController(controller, animated: true, completion: nil)
  }
  
}

enum userType: Int {
  case Rocoo = 0
  case Joe
}
