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
<br \>
**Optional Tuple Return Types**
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
* 參數預設是常數，若想要在function改變參數的值，那必須用關鍵字inout定義該參數
* 輸入的參數不能是常數跟literal value，因為兩者都不能被改變
* 不能有default value
* 在呼叫方法時，要傳入的參數使用&來定義該參數是可以被修改的
* inout參數與function的回傳值不同，是另一種來影響外部輸入參數的方法
```swift
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"
```

<br \>
<br \>
# Function Types
<br \>
**Using Function Types**
<br \>
定義一樣的參數list與function type，就可以將現有的function設定給該常(變)數：
```swift
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}

let mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"

```

<br \>
<br \>
**Function Types as Parameter Types**
<br \>
function的參數可以是另一個function：
```swift
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}

func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
```

<br \>
<br \>
**Function Types as Return Types**
<br \>
function的回傳值也可以是一個function：
```swift
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
// moveNearerToZero now refers to the stepBackward() function

while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
// 3...
// 2...
// 1...
```

<br \>
<br \>
# Nested Functions
```swift
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function

while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
// -4...
// -3...
// -2...
// -1...
```




