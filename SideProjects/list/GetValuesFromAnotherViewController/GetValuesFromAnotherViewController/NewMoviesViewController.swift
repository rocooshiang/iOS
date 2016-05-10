//
//  NewMoviesViewController.swift
//  GetValuesFromAnotherViewController
//
//  Created by Rocoo on 2016/5/10.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

protocol NewMoviesViewControllerDelegate {
  func didDisappearViewController(controller: NewMoviesViewController,movie: String)
}

class NewMoviesViewController: UIViewController{
  
  var delegate: NewMoviesViewControllerDelegate? = nil
  
  @IBOutlet var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let dismissKeyboardImage = UIImage(named: "dismissKeyboard")
    
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
    let rightItem = UIBarButtonItem(image: dismissKeyboardImage, style: .Plain, target: self, action: #selector(NewMoviesViewController.dismissKeyboard))
    toolBar.items = [spaceItem,rightItem]
    
    
    textView.inputAccessoryView = toolBar
    textView.returnKeyType = .Done
    textView.delegate = self

  }
  
  override func viewWillAppear(animated: Bool) {
    textView.text = ""
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  @IBAction func saveClicked(sender: AnyObject) {
    delegate?.didDisappearViewController(self, movie: textView.text)    
  }
  
  func dismissKeyboard(){
    self.view.endEditing(true)
  }
}

// MARK - UITextViewDelegate
extension NewMoviesViewController: UITextViewDelegate{
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    if text == "\n"{
      textView.resignFirstResponder()
      return false
    }
    return true
  }
}
