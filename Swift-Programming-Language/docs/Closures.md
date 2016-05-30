# Closures
<br \>

Global 和 Nested functions都是屬於特殊的closures：
* Global functions有名稱，但是沒辦法捕獲任何值
* Nested functions有名稱且能從其封閉的function捕獲值 
* Closure expressions是沒有名稱的，使用輕量化的寫法，並且利用前後關係來捕獲值


Closure expressions的優化：
* 從前後關係來推斷參數及回傳type
* 單一表達式closures的回傳
* 速記參數名稱($0, $1, $2, 依此類推)
* 尾隨閉包語法(trailing closure)

# Closure Expressions
**The Sort Method**
<br \>
* Closure expressions在不損失明確意圖的前提下，提供了很多種優化寫法，以下會以sort(_:)來step by step說明
* sort方法接受帶有兩個同type參數的closure
* 呼叫sort方法會傳入兩個一樣type的參數，如果回傳true，表示第一個參數將出現在第二個參數前面，false則相反

使用普通function：
```swift 
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, _ s2: String) -> Bool {
  return s1 > s2
}
var reversed = names.sort(backwards)
// reversed is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
```

<br \> 
<br \>
**Closure Expression Syntax**
<br \>
<br \>
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Closures1.png)
<br \>
[(圖片轉自The Swift Programming Language , Closures)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94)
<br \>
* Closure expression可以使用常(變)數當參數，也能使用inout參數，所以default values是不能提供的
* 允許參數及return types是Tuples
* in關鍵字是說明一個Closure expression的body起始位置，也就是說寫在parameters及return types之後

呈現一個closure expression版本backwards(_:_:)：
```swift
reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

因為內容夠簡短，所以用一行來呈現即可：
```swift
reversed = names.sort( { (s1: String, s2: String) -> Bool in return s1 > s2 } )
```

<br \>
<br \>
**Inferring Type From Context**
<br \>
因為sort是被一個String的陣列呼叫，所以Closure expression可以推斷是(String, String) -> Bool，也就是說這些已知道的type可以不寫，另外參數的小括號與箭頭(->)也能省略：
```swift
reversed = names.sort( { s1, s2 in return s1 > s2 } )
```

***Note: 如果因為縮寫而造成code的混淆，可讀性降低的狀況，那就鼓勵還是明確的寫出完整的Closrue expression***
<br \>
<br \>

**Implicit Returns from Single-Expression Closures**
<br \>
Closure expression的body是s1 > s2，很明顯是回傳一個Bool，所以return關鍵字也能省略：
```swift
reversed = names.sort( { s1, s2 in s1 > s2 } )
```

<br \>
<br \>
**Shorthand Argument Names**
<br \>
如果使用速記參數名稱(shorthand argument names)，那可以省略argument list，shorthand argument names的數量與type會由呼叫方法的物件來推斷，in關鍵字也能忽略不寫，下方的$0與$1表示s1與s2：
```swift
reversed = names.sort( { $0 > $1 } )
```

<br \>
<br \>
**Operator Functions**
<br \>
因為String type有定義一個特殊的實現叫大於運算符(>)，是一個有兩個String type參數和Bool的回傳值，那剛好等於我們寫的sort(_:)方法
，所以當我們使用(>)，Swift就會自動推斷，因此Closure expression能更簡單的改寫成：
```swift
reversed = names.sort(>)
```

<br \>
<br \>
# Trailing Closures
如果需要傳入一個closure expression當做是function的參數，但這個closure expression很長，那就可以使用trailing closure代替
```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
  // function body goes here
}

// here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure({
  // closure's body goes here
})

// here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
  // trailing closure's body goes here
}
```

我們將前一段的code改寫成trailing closure：
```swift
reversed = names.sort() { $0 > $1 }
```

如果closure expression是function的唯一一個參數，且使用trailing closure，那可以省略小括號：
```swift
reversed = names.sort { $0 > $1 }
```

使用Array的一個方法map(_:)來呈現trailing closure：
<br \>

***map(_:)可以回傳相對應的值(return type可能與傳入的不一樣)***
```swift
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]
```

<br \>
<br \>
# Capturing Values
Closure可以從上下文來捕獲值，最簡單的例子就是Nested function，如下方incrementer function可以取得runningTotal和amount的值：
```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

執行：
```swift
let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// returns a value of 10
incrementByTen()
// returns a value of 20
incrementByTen()
// returns a value of 30
```

假設又建立了另一個makeIncrementer物件，那新的物件會有自己的stored reference，不會影響到其他物件：
```swift
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// returns a value of 7

incrementByTen()
// returns a value of 40
```

<br \>
<br \>
# Closures Are Reference Types
因為Closures是reference types(Call by reference)，所以上面的例子incrementByTen會一直影響到runningTotal的值，即使將incrementByTen賦與給另一個常數，都是參考一樣的記憶體，所以還是會影響到runningTotal的值：
```swift
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 50
```

<br \>
<br \>
# Nonescaping Closures
* 關鍵字@nonescap可以限制closure的生命週期，如以下範例，closure不得超過someFunctionWithNonescapingClosure function的生命週期，且不能被同function中的其他closure使用

其他closure企圖使用@noescape的closure：
```swift
func someFunctionWithNonescapingClosure(@noescape closure: () -> Void) {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    closure()
  }
  // Compiler error
}
```

noescape closure與escape closure比較：
```swift
func someFunctionWithNonescapingClosure(@noescape closure: () -> Void) {
    closure()
}

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
    completionHandlers.append(completionHandler)
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"  

 
completionHandlers.first?()
print(instance.x)
// Prints "100"

```

<br \>
<br \>
# Autoclosures

