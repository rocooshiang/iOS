//
//  Item1Controller.swift
//  SideMenu
//
//  Created by Rocoo on 2016/5/11.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class Item1Controller: UIViewController {

  @IBOutlet var menuButton: UIBarButtonItem!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      menuButton.target = self.revealViewController()
      menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
}
