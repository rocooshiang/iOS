# Initialization

<br \>
<br \>

## Setting Initial Values for Stored Properties
* 要在initializer assign value到stored property，會直接assign而不會呼叫property observers
* 如果property初始化時擁有一樣的值，那請用default value，不要在initializer assign value

<br \>
<br \>
## Customizing Initialization

##### Initialization Parameters

兩個initializer的struct：
```swift
struct Celsius {
  var temperatureInCelsius: Double
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32.0) / 1.8
  }
  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0
```

<br \>
##### Optional Property Types

如果有property可能為nil，就設成optional property，在initializae時會assign nil當default value：
```swift
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."
```

<br \>
##### Assigning Constant Properties During Initialization

Constant property可以在initializer assign value，之後就不能再變更了，下面例子與上面例子一模一樣，差別在將text改成是constant property：
```swift
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"
```

***Note: 不能在subclass更改constant property***

<br \>
<br \>
## Default Initializers

以下例子因為每個property都有default value，且該class沒有superclass，所以不用寫initializer
```swift
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
```

<br \>
##### Memberwise Initializers for Structure Types

Structure有default initializer叫做memberwise Initializers：
```swift
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```

<br \>
<br \>
## Initializer Delegation for Value Types

* Initializer可以通過呼叫其他Initializer來initialize，避免寫重複的Initializer，這個過程稱為Initializer Delegation
* Initializer Delegation在value types與reference types的規則不一樣，因為value types(Structures and Enumerations)沒有提供繼承，
處理起來相對簡單，而reference types(Classes)有繼承的關係，所以需要去確保所有相關的property都有合適的value，將會在之後的**Class Inheritance and Initialization**介紹
* Value types在initializer使用self.init呼叫同樣為value types的initializer，且只能在initializer使用self.init

建立有三個initializer的structure：
```swift
struct Size {
  var width = 0.0, height = 0.0
}

struct Point {
  var x = 0.0, y = 0.0
}

struct Rect {
  var origin = Point()
  var size = Size()
  init() {}
  init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}
```

分別使用三個initializer來intialize
```swift
let basicRect = Rect()
// basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
// originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
```

***Note: 有額外的方式可以取代initiallizer delegation，詳情請看Extensions***


<br \>
<br \>
## Class Inheritance and Initialization
任何在class的property都必須要有初始值，不管是繼承來的property或是自己的，為了確保這點，Swift提供兩種方式來確認，
叫做Designated Initializers 和 Convenience Initializers

<br \>
##### Designated Initializers and Convenience Initializers
***Designated initializers***
* Designated initializers是class最主要的intializer，一個intializer要完整的intialize所有class的property
* 通常一個class會只有幾個Designated initializers在，通常都只有一個
* 一個class至少要有一個Designated initializers

***Convenience Initializers***
* Convenience Initializers是class次要的intializer，輔助用的
* 呼叫同一個class的Designated initializers，並為其properties提供default value
* 在必要食材定義Convenience Initializers，例如需要快速的初始化某個Designated initializers

<br \>
##### Syntax for Designated and Convenience Initializers
***Designated initializers***

![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Initialization1.png)
<br \>
[(圖片轉自The Swift Programming Language , Initialization)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

<br \>
***Convenience Initializers***

![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Initialization2.png)
<br \>
[(圖片轉自The Swift Programming Language , Initialization)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

<br \>
##### Initializer Delegation for Class Types
Swift採用下方三種規則來做initializers之間的呼叫：
* Designated initializer必須立即呼叫superclass的Designated initializer
* Convenience initializer必須呼叫同class的其他initializer
* Convenience initializer最終必須呼叫一個Designated initializer

***Note: Designated initializer是 delegate up， Convenience initializer是 delegate across***

<br \>
以下圖來表示上方的三種規則：
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Initialization4.png)
<br \>
[(圖片轉自The Swift Programming Language , Initialization)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

* Superclass滿足了rule2和rule3
* Subclass滿足rule1~3

***Note: 以上規則只有影響到你在定義class的initializers，而不會影響到你在建立class的instances***

