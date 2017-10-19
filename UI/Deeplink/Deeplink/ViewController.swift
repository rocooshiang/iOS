//
//  ViewController.swift
//  Deeplink
//
//  Created by Rocoo on 2017/8/22.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureFor()
    
  }
  
  @IBAction func didPressSwitchProfile(_ sender: Any) {
    configureFor()
  }
  
  func configureFor() {
    title = isDev ? "Dev" : "Production"
  }
  
}

