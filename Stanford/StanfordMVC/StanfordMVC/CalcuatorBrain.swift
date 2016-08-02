//
//  CalcuatorBrain.swift
//  StanfordMVC
//
//  Created by Geosat-RD01 on 2016/7/21.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

class CalcuatorBrain{
  
  private var accumulator = 0.0
  private var internalProgram = [AnyObject]()
  
  func setOperand(operand: Double){
    accumulator = operand
    internalProgram.append(operand)
  }
  
  // String不能重複，不然會產生EXC_BAD_INSTRUCTION
  var operations: Dictionary<String,Operation> = [
    "π": Operation.Constant(M_PI),
    "e": Operation.Constant(M_E),
    "±": Operation.UnaryOperation({ -$0 }),
    "√": Operation.UnaryOperation(sqrt),
    "cos": Operation.UnaryOperation(cos),
    "×": Operation.BinaryOperation({$0 * $1}),
    "÷": Operation.BinaryOperation({$0 / $1}),
    "+": Operation.BinaryOperation({$0 + $1}),
    "−": Operation.BinaryOperation({$0 - $1}),
    "=": Operation.Equals
  ]
  
  
  // 定義 associate value 是 Double or function or...
  enum Operation{
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  
  /**
   1. 從 dictionary 取得相對應的操作
   2. 取得 Enum 定義的 associate value
   **/
  func performOperation(symbol: String){
    internalProgram.append(symbol)
    
    if let operation = operations[symbol]{  // 1.
      switch operation {
      case .Constant(let value):   // 2.
        accumulator = value
      case .UnaryOperation(let function):
        accumulator = function(accumulator)
      case .BinaryOperation(let function):
        executeBinaryOperation()
        pending = PendingBinaryOperationInfo(binaryOperation: function, firstOperand: accumulator)
      case .Equals:
        executeBinaryOperation()
      }
    }
  }
  
  func executeBinaryOperation(){
    if pending != nil{
      accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
      pending = nil
    }
  }
  
  private var pending: PendingBinaryOperationInfo?
  
  struct PendingBinaryOperationInfo {
    var binaryOperation: (Double, Double) -> Double
    var firstOperand: Double
  }
  
  typealias PropertyList = AnyObject
  
  var program: PropertyList{
    get{
      return internalProgram
    }
    set{
      clear()
      if let arrayOfOps = newValue as? [AnyObject]{
        for op in arrayOfOps{
          if let operand = op as? Double{
              setOperand(operand)
          }else if let operation = op as? String{
             performOperation(operation)
          }
        }
      }
    }
  }
  
  private func clear(){
    accumulator = 0.0
    pending = nil
    internalProgram.removeAll()
  }
  
  var result: Double{
    get{
      return accumulator
    }
  }
  
}