//
//  ChatViewController.swift
//  FirebaseChat
//
//  Created by Geosat-RD01 on 2016/8/16.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit
import Firebase

let ref = FIRDatabase.database().reference()

class ChatViewController: UIViewController {
  
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var tableView: UITableView!{
    didSet{
      tableView.dataSource = self
      tableView.estimatedRowHeight = 100.0
      tableView.rowHeight = UITableViewAutomaticDimension
    }
  }
  @IBOutlet var messageInputArea: UITextField!{
    didSet{
      messageInputArea.delegate = self
    }
  }
  
  var activeField: UITextField?
  var tap : UITapGestureRecognizer?
  
  var userName: String!
  
  var messageContents = [MessageContent]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    registerKeyboardNotifications()
    registerDataCallback()
    initGesture()
  }
  
  override func viewDidDisappear(animated: Bool) {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func registerKeyboardNotifications(){
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWasShown(notification: NSNotification){
    tableView.addGestureRecognizer(tap!)
    
    if let info = notification.userInfo, let kbSize = info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size{
      let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = contentInsets
      
      var aRect = self.view.frame;
      aRect.size.height -= kbSize.height;
      if !CGRectContainsPoint(aRect, activeField!.frame.origin) {
        scrollView.scrollRectToVisible(activeField!.frame, animated: true)
      }
    }
  }
  
  func keyboardWillBeHidden(notification: NSNotification){
    tableView.removeGestureRecognizer(tap!)
    
    let contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
  }
  
  func dismissKeyboard(){
    self.view.endEditing(true)
  }
  
  func initGesture(){
    tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.dismissKeyboard))
  }
  
  func registerDataCallback(){
    ref.child("messages").observeEventType(FIRDataEventType.ChildAdded, withBlock: { (snapshot) -> Void in
      if let messageData = snapshot.value as? NSDictionary, messageContent = MessageContent(data: messageData) {
        self.messageContents.append(messageContent)
        self.tableView.reloadData()
        self.scrollToButtom()
        for message in self.messageContents{
          print("\(message.userName), \(message.message),\(message.time)")
        }
      }else {
        print("Fetch data failed")
      }
    })
  }
  
  func scrollToButtom(){
    let lastIndex = NSIndexPath(forRow: self.messageContents.count - 1, inSection: 0)
    self.tableView.scrollToRowAtIndexPath(lastIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
  }
  
  @IBAction func sendMessage() {
    guard let message = messageInputArea.text where !message.isEmpty else{
      showAlert("Please write the message then upload.", message: nil, buttonText: "ok")
      return
    }
    uploadMessage(message)
    messageInputArea.text?.removeAll()
  }
  
  func uploadMessage(message: String){
    let key = ref.child("post").childByAutoId().key
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    let time = formatter.stringFromDate(NSDate())
    let post = ["\(key)":["userName": userName, "message": message, "time": time]]
    ref.child("messages").updateChildValues(post)
  }
  
}

// MARK: - UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate{
  func textFieldDidBeginEditing(textField: UITextField) {
    activeField = textField
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    activeField = nil
  }
}

// MARK: - UITableViewDataSource
extension ChatViewController : UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageContents.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
    if messageContents[indexPath.row].userName == userName {
      let cell = tableView.dequeueReusableCellWithIdentifier("myMessageCell") as! ChatTableViewCell
      cell.message.text = messageContents[indexPath.row].message
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("friendMessageCell") as! ChatTableViewCell
      cell.userName.text = messageContents[indexPath.row].userName + ":"
      cell.message.text = messageContents[indexPath.row].message
      return cell
    }
    
  }
  
}


