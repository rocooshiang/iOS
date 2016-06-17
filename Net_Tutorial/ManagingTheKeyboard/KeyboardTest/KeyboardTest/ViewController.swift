//
//  ViewController.swift
//  KeyboardTest
//
//  Created by Geosat-RD01 on 2016/6/17.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var scrollView: UIScrollView!
  
  @IBOutlet var firstTextField: UITextField!
  @IBOutlet var secondTextField: UITextField!
  
  var activeField : UITextField?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTextFieldAttributes(textField: firstTextField)
    setTextFieldAttributes(textField: secondTextField)
    registerForKeyboardNotifications()
  }
  
  
  override func viewDidDisappear(animated: Bool) {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  
}

extension ViewController{
  
  func setTextFieldAttributes(textField textField: UITextField){
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let dismissKeyboardImage = UIImage(named: "dismissKeyboard")
    
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
    let rightItem = UIBarButtonItem(image: dismissKeyboardImage, style: .Plain, target: self, action: #selector(ViewController.dismissKeyboard))
    toolBar.items = [spaceItem,rightItem]
    
    textField.inputAccessoryView = toolBar
    textField.returnKeyType = .Done
    textField.delegate = self
  }
  
  func registerForKeyboardNotifications(){
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWasShown(notification: NSNotification){
    
    if let info = notification.userInfo, let kbSize = info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size{
      let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = contentInsets
      
      // If active text field is hidden by keyboard, scroll it so it's visible
      var aRect = self.view.frame;
      aRect.size.height -= kbSize.height;
      if !CGRectContainsPoint(aRect, activeField!.frame.origin) {
        scrollView.scrollRectToVisible(activeField!.frame, animated: true)
      }
    }
    
  }
  
  func keyboardWillBeHidden(notification: NSNotification){
    
    let contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
  }
  
  func dismissKeyboard(){
    view.endEditing(true)
  }
  
}

extension ViewController: UITextFieldDelegate{
  
  func textFieldDidBeginEditing(textField: UITextField) {
    activeField = textField
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    activeField = nil
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    if string == "\n"{
      textField.resignFirstResponder()
      return false
    }
    return true
  }
  
}
