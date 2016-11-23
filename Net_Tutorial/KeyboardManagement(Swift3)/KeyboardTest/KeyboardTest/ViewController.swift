//
//  ViewController.swift
//  KeyboardTest
//
//  Created by Geosat-RD01 on 2016/6/17.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var answer: UITextView!
    var question: UILabel!
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
}

// MARK: - Test keyboard management
extension ViewController{
    func setLayout(){
        
        registerForKeyboardNotifications()
        tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        tap.cancelsTouchesInView = false
        
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 64, width: device.screenWidth, height: device.screenHeight-64)
        scrollView.contentSize = CGSize(width: device.screenWidth, height: device.screenHeight-64)
        scrollView.backgroundColor = colorFromRGB(213, green: 213, blue: 213)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        question = UILabel(frame: CGRect(x: 20, y: 20, width: device.screenWidth-40, height: 0))
        question.textColor = .black
        question.text = "The following recipes show how you can use stack views to create layouts of increasing complexity. Stack views are a powerful tool for quickly and easily designing your user interfaces. Their attributes allow a high degree of control over how they lay out their arranged views. You can augment these settings with additional, custom constraints; however, this increases the layout’s complexity."
        question.textAlignment = .left
        question.numberOfLines = 0
        question.sizeToFit()
        scrollView.addSubview(question)
        
        answer = UITextView(frame: CGRect(x: 20, y: question.frame.height + 50, width: device.screenWidth-40, height: (device.screenWidth-40)/2))
        answer.layer.borderColor = colorFromRGB(152, green: 152, blue: 152).cgColor
        answer.layer.cornerRadius = 5
        answer.layer.borderWidth = 1
        answer.text = "Type your answer..."
        answer.textColor = .lightGray
        answer.font = UIFont.systemFont(ofSize: 17)
        answer.delegate = self
        
        scrollView.addSubview(answer)
        
        let save = UIButton(type: .system)
        save.frame = CGRect(x: Double(device.screenWidth/2 - 60), y: Double(question.frame.height+answer.frame.height+80), width: 120.0, height: 50.0)
        save.setTitle("Save", for: .normal)
        
        save.titleLabel?.font =  UIFont.systemFont(ofSize: 17)
        save.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        save.backgroundColor = colorFromRGB(63, green: 63, blue: 63)
        save.setTitleColor(.white, for: .normal)
        save.layer.borderColor = UIColor.clear.cgColor
        save.layer.cornerRadius = 25
        save.layer.borderWidth = 1
        scrollView.addSubview(save)
        
        let contentHeight = question.frame.height+answer.frame.height+160
        scrollView.contentSize = CGSize(width: device.screenWidth, height: contentHeight)
        
        // WTF, 為何最上層是view ?!
        view.addGestureRecognizer(tap)
    }
    
    func buttonTapped(sender: UIButton){
        
    }
    
    func tapGesture(){
        dismissKeyboard()
    }
    
    
}


// MARK: - About Keyboard show and hidden notification.
extension ViewController{
    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        
        if let info = notification.userInfo, let kbSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            /** If active textView is hidden by keyboard, scroll it so it's visible **/
            
            // 官方寫法：只要textView的CGPoint在可視範圍(不被鍵盤擋住)，就不做View的調整
            //            var scrollViewRect = scrollView.frame;
            //            scrollViewRect.size.height -= kbSize.height
            //
            //            if !scrollViewRect.contains(answer!.frame.origin) {
            //                scrollView.scrollRectToVisible(answer!.frame, animated: true)
            //            }
            
            
            // 自己算： 只要鍵盤擋住了textView的任一部分，都將textView調整到鍵盤上方間隔20的位置
            if scrollView.frame.height - answer.frame.maxY < kbSize.height{
                print("TextView is hidden by keyboard.")
                var frame = answer!.frame
                let height = frame.height + 20
                frame.size.height = height
                
                scrollView.scrollRectToVisible(frame, animated: true)
            }
            
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        scrollView.contentInset = .zero;
        scrollView.scrollIndicatorInsets = .zero;
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
}


// MARK: - UITextViewDelegate
extension ViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.replacingOccurrences(of: "\n", with: "").trimmingCharacters(in: .whitespaces).isEmpty {
            textView.text = "Type your answer..."
            textView.textColor = UIColor.lightGray
        }
    }
}

