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

<br \>
##### Designated and Convenience Initializers in Action

因為classes不像structure有memberwise initializer，所以必須提供designated initializer：
```swift
class Food {
  var name: String
  
  init(name: String) {
    self.name = name
  }
  
  convenience init() {
    self.init(name: "[Unnamed]")
  }
}

let namedMeat = Food(name: "Bacon")
// namedMeat's name is "Bacon"

let mysteryMeat = Food() 
// mysteryMeat's name is "[Unnamed]"
```

以上程式碼配置如下圖：
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Initialization8.png)
<br \>
[(圖片轉自The Swift Programming Language , Initialization)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

一個subclass，使用desinated initializer初始一個叫quantity的property，以及superclass的name property：
```swift
class RecipeIngredient: Food {
  var quantity: Int
  
  init(name: String, quantity: Int) {
    self.quantity = quantity
    super.init(name: name)
  }
  
  override convenience init(name: String) {
    self.init(name: name, quantity: 1)
  }
}
```

以上程式碼配置如下圖：
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Initialization9.png)
<br \>
[(圖片轉自The Swift Programming Language , Initialization)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

以下程式碼是購物清單確認表，因為沒有定義任何initializers，且每個property都有default value，ShoppingListItem會自動繼承所有superclass的designated和convenience initializers：
```swift
class ShoppingListItem: RecipeIngredient {
    var purchased = false
    
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
```

以上程式碼配置如下圖：
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Initialization10.png)
<br \>
[(圖片轉自The Swift Programming Language , Initialization)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)

以下例子使用上放3個自定的class，breakfastList是[ShoppingListItem] type：
```swift
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.description)
}
// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘
```

<br \>
<br \>
## Failable Initializers

為了應付錯誤的參數，或是在某種條件下不讓初始化成功，利用關鍵字**init?**就可以定義一個Failable Initializers，回傳是一個Optional

***Note: 不能同時定義擁有同樣名稱及參數的 failable 和 nonfailable initializer***

建立一個有Failable Initializers的structure，如果輸入的參數是空的就回傳nil：
```swift
struct Animal {
  let species: String
  
  init?(species: String) {
    if species.isEmpty { return nil }
    self.species = species
  }
}
```

利用if let判斷是否初始化成功：
```swift
let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal
 
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// Prints "An animal was initialized with a species of Giraffe"
```

初始化失敗：
```swift
let anonymousCreature = Animal(species: "")
// anonymousCreature is of type Animal?, not Animal
 
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// Prints "The anonymous creature could not be initialized"
```

<br \>
##### Failable Initializers for Enumerations

如果沒有match到任何case，則回傳nil表示初始化失敗：
```swift
enum TemperatureUnit {
  case Kelvin, Celsius, Fahrenheit
  
  init?(symbol: Character) {
    switch symbol {
    case "K":
      self = .Kelvin
    case "C":
      self = .Celsius
    case "F":
      self = .Fahrenheit
    default:
      return nil
    }
  }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}
// Prints "This is not a defined temperature unit, so initialization failed."
```

<br \>
##### Failable Initializers for Enumerations with Raw Values

Enumerations會自動接收 failable initializer，init?(rawValue:)：
```swift
enum TemperatureUnit: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
 
let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."
 
let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// Prints "This is not a defined temperature unit, so initialization failed."
```

<br \>
##### Propagation of Initialization Failure

failable initializer可以在同一個class, structure, or enumeration delegate across to another failable initializer，同理 subclass failable initializer可以delegate up to a superclass failable initializer

***Note: A failable initializer can also delegate to a nonfailable initializer***

初始化CartItem會先判斷quantity是否是有效值，無效的話初始化就會立即失敗，之後的程式碼都不會在執行，相反地，成功就會繼續判斷後面name是否為空：
```swift
class Product {
  let name: String
  
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
  }
}

class CartItem: Product {
  let quantity: Int
  
  init?(name: String, quantity: Int) {
    if quantity < 1 { return nil }
    self.quantity = quantity
    super.init(name: name)
  }
}
```

初始化成功：
```swift
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// Prints "Item: sock, quantity: 2"
```

以下初始化失敗在name為空：
```swift
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// Prints "Unable to initialize one unnamed product"
```

<br \>
##### Overriding a Failable Initializer
* subclass可以override superclass的failable initializer，另外，如果不允許失敗，還可以將其改變為nonfailable intializer
* 如果是要將superclass的failable initializer，在subclass override成nonfailable intializer，那要強制unwrap，因為init?回傳結果是一個Optional

以下class允許name是有效值或是nil，不允許為空：
```swift
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
```

AutomaticallyNamedDocument override兩個superclass的initializer，確保name都有值：
```swift
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
```

在subclass的nonfailable initializer使用force unwrapping呼叫superclass的failable initializer：
```swift
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}
```

<br \>
<br \>
## Required Initializers

在initializer前加上關鍵字**required**，表示繼承的subclass需要執行這個intializer：
```swift
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}
```

subclass執行superclass的required intializer不需要加上override，但是還是要在前面加上required：
```swift
class SomeSubclass: SomeClass {
  required init() {
    // subclass implementation of the required initializer goes here
  }
}
```

<br \>
<br \>
## Setting a Default Property Value with a Closure or Function

範例:
```swift
class SomeClass {
    let someProperty: SomeType = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return someValue
    }()
}
```

***Note: 如果使用closure初始化property，切記在大括號內還沒有被初始化完成，意思就是不能在closure使用其他的property，即使那些property有default value，也沒辦法使用隱含的property self或是呼叫方法***

以棋盤為例子，下方式一個8x8的棋盤，由黑白色交替，boardColors控制每個格子的顏色(共有64個Bool value的array)，true代表黑色，false代表白色，左上角是第一個item，右下角是最後一個item，boardColors由一個closure初始化：
```swift
struct Chessboard {
  let boardColors: [Bool] = {
    var temporaryBoard = [Bool]()
    var isBlack = false
    
    for i in 1...8 {
      for j in 1...8 {
        temporaryBoard.append(isBlack)
        isBlack = !isBlack
      }
      isBlack = !isBlack
    }
    
    return temporaryBoard
  }()
  
  func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
    return boardColors[(row * 8) + column]
  }
}
```

<br \>
以上程式碼配置如下圖：

![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Initialization11.png)
<br \>
[(圖片轉自The Swift Programming Language , Initialization)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)


查詢每個格子的顏色：
```swift
let board = Chessboard()
print(board.squareIsBlackAtRow(0, column: 1))
// Prints "true"

print(board.squareIsBlackAtRow(7, column: 7))
// Prints "false"
```
