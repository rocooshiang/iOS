# Extensions

Extensions與Objective-C的categories類似，但是沒有名稱

Extension可以做的事情：
* 添加computed instance properties和computed type properties
* 定義instance methods或是type methods
* 提供新的initializers
* 定義subscripts
* 定義和使用新的nested types
* 使現有的type遵循protocol

***Note: type可使用Extensions擴充新功能，但是不能override已存在的功能***

<br \>
<br \>
## Extension Syntax

使用 **extension** 關鍵字來定義一個extensions的功能：
```swift
extension SomeType {
    // new functionality to add to SomeType goes here
}
```

可以使用extensions來採用一或多個protocols：
```swift
extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}
```

***Note: 為一個type extend新的功能，那任何這個type的實例都能使用新的功能，即使extension是在實例被建立之後才擴充的***

<br \>
<br \>
## Computed Properties

擴充Double，定義五個單位的計算方式：
```swift
extension Double {
  var km: Double { return self * 1_000.0 }
  var m: Double { return self }
  var cm: Double { return self / 100.0 }
  var mm: Double { return self / 1_000.0 }
  var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"
```

***Note: Extensions可以增加computed properties，但是不能增加stored properties及為已存在的properties新增observers***

<br \>
<br \>
## Initializers
Extension可以為class新增convenience initializers，但是不能新增designated initializers和deinitializers

定義三個structures
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
}
```

使用default initializer(因為structures的properties都有default value)及memberwise initializer：
```swift
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))
```

擴充Rect的initializer：
```swift
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
```

使用擴充的initializer：
```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
```

***Note: 使用Extension提供了一個新的initializer，必須保證建構過程能夠讓所有實例完全初始化***

<br \>
<br \>
## Methods

Extension可以增加instance methods及type methods，下方為Int新增一個method叫repetitions，有一個參數是沒有回傳值也沒有參數的function：
```swift
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
```

在Extension之後，現在每個integer number都可以使用repetitions的方法：
```swift
3.repetitions({
    print("Hello!")
})
// Hello!
// Hello!
// Hello!
```

使用trailing closure句法:
```swift
3.repetitions {
    print("Goodbye!")
}
// Goodbye!
// Goodbye!
// Goodbye!
```

<br \>
##### Mutating Instance Methods

Structure 和 enumeration methods如果要修改 self 或是properties，那必須在instance methods加上mutating：
```swift
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
// someInt is now 9
```

<br \>
<br \>
## Subscripts
幫Int type新增一個subscript，subscript [n]表示回傳該Int從右邊數來的第n個數值：
```swift
extension Int {
  subscript(digitIndex: Int) -> Int {
    var decimalBase = 1
    
    for _ in 0..<digitIndex {
      decimalBase *= 10
    }
    
    //self表示該Int
    return (self / decimalBase) % 10
  }
}

746381295[0]
// returns 5

746381295[1]
// returns 9

746381295[2]
// returns 2

746381295[8]
// returns 7
```

以上例子如果輸入的index超過Int的range，那會回傳0：
```swift
746381295[9]
// returns 0, as if you had requested:
0746381295[9]
```

<br \>
<br \>
## Nested Types

Extensions可以為classes, structures和enumerations新增nested types:
```swift
extension Int {
  enum Kind {
    case Negative, Zero, Positive
  }
  
  var kind: Kind {
    switch self {
    case 0:
      return .Zero
    case let x where x > 0:
      return .Positive
    default:
      return .Negative
    }
  }
  
}
```

現在可以使用以上在extensions所定義的nested types：
```swift
func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 +"
```


