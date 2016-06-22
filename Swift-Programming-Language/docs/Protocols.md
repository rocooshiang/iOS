# Protocols

<br \>
<br \>
## Protocol Syntax

定義protocol類似於classes：
```swift
protocol SomeProtocol {
    // protocol definition goes here
}
```

自訂的structure採用某個或多個protocols：
```swift
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}
```

如果class有superclass，那protocol放在superclass之後：
```swift
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}
```

<br \>
<br \>
## Property Requirements

* Protocol可以要求採用它的type提供instance property或是type property，然後可以指定property名稱其type，
但是不能指定是一個stored property或computed property
* Protocol可以指定每個property是read-only，或是可讀寫的，假設是一個可讀寫的property，那採用的type
不能將它定義為constant stored property或是read-only computed property

定義一個可讀寫的mustBeSettable與read-only的doesNotNeedToBeSettable property：
```swift
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
```

總是在type properties前加上 **static**：
```swift
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
```

Protocol只有一個gettable的fullName property，structure採用此protocol，所以必須有一個fullName的property：
```swift
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"
```

以下示範classes採用protocol，定義fullName是一個computed property(如果是read-only，那 get{} 可以忽略，直接寫return就行)：
```swift
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"
```

<br \>
<br \>
## Method Requirements
* 在protocol定義methods時，與一般宣告方法一樣，但是不需要加上大括號及body
* 不能再protocol裡指定一個method的parameter的default value

定義一個有type methods的protocol，如果採用此protocol是一個class，那可以使用 **class** 或 **static**來執行該method：
```swift
protocol SomeProtocol {
    static func someTypeMethod()
}
```

有instance method的protocol：
```swift
protocol RandomNumberGenerator {
    func random() -> Double
}
```

履行protocol定義的method：
```swift
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.37464991998171"

print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"

```

<br \>
<br \>
## Mutating Method Requirements

***Note: 在履行mutating methods時，如果是classes那不用標示mutating關鍵字，enumerations和structures則需要***

定義一個擁有mutating method的protocol，也就是說，預期這個protocol被採用時，執行該method會有屬性的改變：
```swift
protocol Togglable {
    mutating func toggle()
}
```

```swift
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
// lightSwitch is now equal to .On
```

<br \>
<br \>
## Initializer Requirements

與一般設計initializer相同，只是後面不用大括號及body：
```swift
protocol SomeProtocol {
    init(someParameter: Int)
}
```

<br \>
##### Class Implementations of Protocol Initializer Requirements

當你要履行initializer時，可以使用 designated initializer 或 convenience initializer，
兩者都必須在前面加上 **required**關鍵字，如：
```swift
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}
```

***Note: 你不需要在一個final class履行initializer前加上required，因為final class已經不能被繼承了***

當一個subclass有從superclass overrides initializer，且也有從protocol implements initializer時，必須在
subclass的initializer同時加上 **required** 及 **override** 關鍵字：
```swift
protocol SomeProtocol {
  init()
}

class SomeSuperClass {
  init() {
    // initializer implementation goes here
  }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
  // "required" from SomeProtocol conformance; "override" from SomeSuperClass
  required override init() {
    // initializer implementation goes here
  }
}
```
