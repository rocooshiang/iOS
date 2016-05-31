# Enumerations
<br \>
<br \>

# Enumeration Syntax
<br \>
Swift不像C，Enumeration並沒有default value，每個Enumeration及case name開頭請用大寫：
```swift
enum CompassPoint {
    case North
    case South
    case East
    case West
}
```

可以在同一行定義很多case：
```swift
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
```

如果變數已經被初始化，那之後便可以透過推斷來知道是什麼Enumeration，可以更簡潔的定義變數：
```swift
var directionToHead = CompassPoint.West

directionToHead = .East
```

<br \>
<br \>
# Matching Enumeration Values with a Switch Statement
<br \>
可以用switch來辨別是哪個Enumeration的成員：
```swift
directionToHead = .South
switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
```

我們在[Control Flow](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Control-Flow.md)提到switch需要提供完整的case，不然就要使用default來塞選case以外可能性：
```swift
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"

```

<br \>
<br \>
# Associated Values
<br \>
定義UPCA及QRCode的associated values：
```swift
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
```

初始化：
```swift
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
```

利用switch來塞選是哪一個Enumeration，如果要使用associated values，請在前面加上let或是var：
```swift
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, var product, var check):
  product += 1
  check += 2
  print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
  print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

如果一個case要設定全部都是常數或是變數，則在case之後定義let或var即可：
```swift
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
  print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
  print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

<br \>
<br \>
# Raw Values
* raw values與associated values是不同的，raw values在定義完Enumeration後值永遠是一樣，而associated values會隨著定義新值而有所不同
* raw values可以是string、integer、float等

定義一個raw values是Character的Enumeration：
```swift
enum ASCIIControlCharacter: Character {
  case Tab = "\t"
  case LineFeed = "\n"
  case CarriageReturn = "\r"
}
```

<br \>
<br \>
**Implicitly Assigned Raw Values**
* 當Enumeration的case type為integer或string，會自動assign default value，interger是從0開始，而string會是與case name相同的string

Planet.Mercury有明確的表示raw value是1，那Planet.Venus就是2（依此類推）：
```swift
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
```

CompassPoint.North的raw value是"North"：
```swift
enum CompassPoint: String {
    case North, South, East, West
}
```

取得raw value：
```swift
let earthsOrder = Planet.Earth.rawValue
// earthsOrder is 3
 
let sunsetDirection = CompassPoint.West.rawValue
// sunsetDirection is "West"
```

<br \>
<br \>
**Initializing from a Raw Value**
<br \>
* 利用raw value初始化是可能失敗的，因為沒辦法確定assign的值，是不是能match到raw value，所以回傳的物件是一個optional

利用raw value來初始化：
```swift
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.Uranus
```

因為raw value沒辦法match，所以回傳是一個nil：
```swift
let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11"
```

<br \>
<br \>
# Recursive Enumerations
<br \>

遞迴枚舉(recursive enumerations)就是在自己的enumeration裡又使用了自己，如下面ArithmeticExpression，將需要使用到遞迴的case前面使用indirect關鍵字：
```swift
enum ArithmeticExpression {
  case Number(Int)
  indirect case Addition(ArithmeticExpression, ArithmeticExpression)
  indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

enumeration的所有case都要使用遞迴：
```swift
indirect enum ArithmeticExpression {
  case Number(Int)
  case Addition(ArithmeticExpression, ArithmeticExpression)
  case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

就可以實現一些計算了：
```swift
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))  // (5 + 4) * 2
```

<br \>
<br \>
# Other
<br \>
將上面Recursive Enumerations的例子使用protocol：
```swift
protocol EvaluateDelegate {
  func evaluate() -> Int
}

indirect enum ArithmeticExpression: EvaluateDelegate{
  
  case Number(Int)
  case Addition(ArithmeticExpression,ArithmeticExpression)
  case Multiplication(ArithmeticExpression,ArithmeticExpression)
  
  // conform protocol
  func evaluate() -> Int {
    switch self {
    case .Number(let value):
      return value
    case .Addition(let left, let right):
      return left.evaluate() + right.evaluate()
    case .Multiplication(let left, let right):
      return left.evaluate() * right.evaluate()
    }
  }
}

let four = ArithmeticExpression.Number(4)
let five = ArithmeticExpression.Number(5)
let sum = ArithmeticExpression.Addition(four, five)
let product = ArithmeticExpression.Multiplication(sum, five) // (4 + 5) * 5
print(product.evaluate())
// Prints: "45"

```

用enumeration儲存Device：
```swift
enum Devices: CGSize {
  case iPhone4And4S = "{320, 480}"
  case iPhone5And5S = "{320, 568}"
  case iPhone6 = "{375, 667}"
  case iPhone6Plus = "{414, 736}"
  case iPad = "{768, 1024}"
}


extension CGSize: StringLiteralConvertible {
  public init(stringLiteral value: String) {
    let size = CGSizeFromString(value)
    self.init(width: size.width, height: size.height)
  }
  
  public init(extendedGraphemeClusterLiteral value: String) {
    let size = CGSizeFromString(value)
    self.init(width: size.width, height: size.height)
  }
  
  public init(unicodeScalarLiteral value: String) {
    let size = CGSizeFromString(value)
    self.init(width: size.width, height: size.height)
  }
}

let device = Devices.iPhone6Plus
let deviceSize = device.rawValue
print("\(device): width is \(deviceSize.width), height is \(deviceSize.height)")
// Prints : "iphone6Plus: width is 414.0, height is 736.0"
```
