//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Geosat-RD01 on 2016/4/27.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var tap: UIButton!
  @IBOutlet var count: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    count.text = "\(0)"
    
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.addCount))
    swipe.direction = [.Up, .Down, .Right, .Left]
    tap.addGestureRecognizer(swipe)
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.addCount))
    tap.addGestureRecognizer(pan)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }

  @IBAction func resetClicked(sender: AnyObject) {
    count.text = "\(0)"
  }
  
  func addCount(){
    count.text = "\(Int(count.text!)! + 1)"
  }

}

