//: Playground - noun: a place where people can play

import UIKit


func registerForKeyboardNotifications(){
  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(notification:)), name: .UIKeyboardWillShow, object: nil)
  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
}

@objc func keyboardWillBeShown(notification: NSNotification){
  
  if let info = notification.userInfo, let kbSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
    
    let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 100.0, 0.0)
    tableView.contentInset = contentInsets
    tableView.scrollIndicatorInsets = contentInsets
    
    /** If active textView is hidden by keyboard, scroll it so it's visible **/
    
    guard let activeTextField = activeTextField else {
      return
    }
    
    if tableView.frame.height - activeTextField.frame.maxY < kbSize.height{
      var frame = activeTextField.frame
      let height = frame.height + 20
      frame.size.height = height
      tableView.scrollRectToVisible(frame, animated: true)
    }
    
  }
}

@objc func keyboardWillBeHidden(notification: NSNotification){
  tableView.contentInset = .zero;
  tableView.scrollIndicatorInsets = .zero;
}

