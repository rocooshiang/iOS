//
//  Extension.swift
//  SwiftyJsonDemo
//
//  Created by Rocoo on 2016/11/9.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
  func connectionFailAlert(){
    let alert = UIAlertController(title: connectionFailTitle, message: connectionFailMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
  }
  
}
