//
//  ViewController.swift
//  CurrentTime
//
//  Created by Geosat-RD01 on 2016/5/3.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var currentTime: UILabel!
  var screenWidth : CGFloat!
  override func viewDidLoad() {
    super.viewDidLoad()
    screenWidth = UIScreen.mainScreen().bounds.size.width
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }

  @IBAction func refresh(sender: AnyObject) {
    
    let now = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MMM dd, yyyy, HH:mm:ss a"
    
    // Reference: http://www.loc.gov/standards/iso639-2/php/English_list.php
    formatter.locale = NSLocale(localeIdentifier: "en")
    let currentTime = formatter.stringFromDate(now)
    self.currentTime.text = currentTime

  }

}

