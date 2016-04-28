//
//  ViewController.swift
//  TapCounter
//
//  Created by Geosat-RD01 on 2016/4/24.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var count: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resetCount()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  @IBAction func resetClicked(sender: AnyObject) {
    resetCount()
  }
  
  @IBAction func tabClicked(sender: AnyObject) {
    addCount()
  }
  
  func addCount(){
    count.text = "\(Int(count.text!)! + 1)"
  }
  
  func resetCount(){
    count.text = "\(0)"
  }
}

