//
//  ViewController.swift
//  StanfordMVC
//
//  Created by Geosat-RD01 on 2016/7/19.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private var display: UILabel!
  
  private var userIsIntheMiddleOfTyping = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  @IBAction private func touchDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsIntheMiddleOfTyping{
      let textCurrentlyInDisplay = display.text!
      display.text = textCurrentlyInDisplay + digit
    }else{
      display.text = digit
    }
    userIsIntheMiddleOfTyping = true
  }
  
  private var displayValue : Double{
    get{
      return Double(display.text!)!
    }
    set{
      display.text = String(newValue)
    }
  }
  
  let brain = CalcuatorBrain()
  
  @IBAction private func performOperation(sender: UIButton) {
    
    if userIsIntheMiddleOfTyping{
    
      brain.setOperand(displayValue)
      userIsIntheMiddleOfTyping = false
    }
    
    if let mathematicalSymbol = sender.currentTitle{
      brain.performOperation(mathematicalSymbol)
    }
    displayValue = brain.result
  }
  
  
}

