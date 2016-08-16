//
//  Login.swift
//  FirebaseChat
//
//  Created by Rocoo on 2016/8/16.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class Login: UIViewController {
  
  let chatIdentifier = "chat"
  var userName: String?
  
  @IBOutlet weak var userRocoo: UIButton!
  @IBOutlet weak var userJoe: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setButton(userRocoo)
    setButton(userJoe)
  }
  
  func setButton(button: UIButton){
    button.layer.cornerRadius = 2
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.whiteColor().CGColor
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == chatIdentifier {
      if let namemvc = segue.destinationViewController as? ChatViewController {
        namemvc.userName = self.userName!
      }
    }
  }
  
  
  @IBAction func selectUser(sender: UIButton) {
    if let user = userType(rawValue: sender.tag){
      switch user {
      case .Rocoo:
        userName = "Rocoo"
      case .Joe:
        userName = "Joe"
      }
      performSegueWithIdentifier(chatIdentifier, sender: nil)
    }
  }
  
  
  
}
