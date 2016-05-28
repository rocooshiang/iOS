# Functions

# Function Parameters and Return Values
**Functions Without Return V alues**
<br \>
其實宣告沒有回傳值，function還是會回傳特殊的Void type，是一個零成員的tuple，即( )：
```swift
func sayGoodbye(personName: String) {
  print("Goodbye, \(personName)!")
}
let say = sayGoodbye("Dave")  //()
```

<br \>
<br \>
# Function Parameters and Return Values
**Optional Tuple Return Types**
<br \>
(Int, Int)? 與 (Int?, Int?)是不同的，前者是整個tuple是一個optional，後者是tuple內各別元素是optional：
```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
  if array.isEmpty { return nil }
  var currentMin = array[0]
  var currentMax = array[0]
  for value in array[1..<array.count] {
    if value < currentMin {
      currentMin = value
    } else if value > currentMax {
      currentMax = value
    }
  }
  return (currentMin, currentMax)
}

if let bounds = minMax([8, -6, 2, 109, 3, 71]) {
  print("min is \(bounds.min) and max is \(bounds.max)")
}
// Prints "min is -6 and max is 109"
```

<br \>
<br \>
**Function Parameter Names**
* 參數名稱有分外部跟內部，外部是提供給呼叫function的物件使用，內部就是提供給function使用
* 通常我們外部跟內部的參數名稱會使用一樣的名稱
* 第一個外部參數名稱會被遺漏，之後的參數名稱則都會顯示

使用一樣的內外部參數名稱(注意看呼叫function的第一個參數名稱被遺漏了)：
```swift
func talk(name: String, message: String){
  print("\(message) \(name)")
}
talk("Rocoo", message: "hello")
```

使用不同的內外部參數名稱(正常我們只會定義第一個參數的外部名稱，因為會被遺漏)：
```swift
func talk(externalName internalName: String, externalMessage internalMessage: String){
  print("\(internalMessage) \(internalName)")
}

talk(externalName: "Rocoo", externalMessage: "hello")
```

<br \>
<br \>
**Omitting External Parameter Names**
<br \>
使用下底線(_)來告知我的外部名稱要忽略，第一個參數原本就忽略了，故不用特別定義：
```swift
func someFunction(firstParameterName: Int, _ secondParameterName: Int) {

}
someFunction(1, 2)
```

<br \>
<br \>
**Default Parameter Values**
<br \>
確保有預設值的參數放在參數列的最後：
```swift
func someFunction(parameter1: Int ,parameter2: Int = 12)-> Int {
  return parameter2
}

let result = someFunction(10, parameter2: 6) // result is 6
let result2 = someFunction(12) // result2 is 12
```

沒有將有預設值的參數放在最後，那後面的參數又設定忽略外部參數名稱就會出錯了：
```swift
func someFunction(parameter1: Int = 1, _ parameter2: Int )-> Int {
  return parameter2
}

let result = someFunction(6, 10) // result is 6
let result2 = someFunction(12) // Missing argument for parameter #2 in call
```

<br \>
<br \>
**In-Out Parameters**
