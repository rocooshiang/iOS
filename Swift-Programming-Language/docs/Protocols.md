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

<br \>
<br \>
## Protocols as Types

Protocols本身不實作任何功能，但是能作為type來使用

使用時機：
* 作為function，method及initializer中的parameter type或return type
* 作為constant，variable，property的type
* 作為Array，Dictionary或其他容器中的元素type

***Note: 與其他type一樣，使用駝峰式命名法***

示範protocols as types，constant generator是一個RandomNumberGenerator的protocol，：
```swift
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

// Random dice roll is 3
// Random dice roll is 5
// Random dice roll is 4
// Random dice roll is 5
// Random dice roll is 4
```

<br \>
<br \>
## Delegation
* Delegation是一種design pattern，它允許classes或structures將一些需要它們負責的功能交由(delegate)給其他的type
* Delegation定義protocols來封裝那些需要被委托的functions和methods，使遵循者擁有這些被委托的functions和methods
* Delegation可以用來響應特定的動作或接收外部資料源提供的資料，而無需要知道外部資料源的type


 下面示範一個Snakes and Ladders的遊戲(在Control Flow提到過的)，之前是用迴圈跑隨機數值，
 這次使用Dice instance的rolls方法來取隨機數，採用DiceGame和DiceGameDelegate protocol：
 ```swift
 protocol RandomNumberGenerator {
  func random() -> Double
}

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


class Dice {
  let sides: Int
  let generator: RandomNumberGenerator
  init(sides: Int, generator: RandomNumberGenerator) {
    self.sides = sides
    self.generator = generator
  }
  func roll() -> Int {
    return Int(generator.random() * Double(sides)) + 1
  }
}


protocol DiceGame {
  var dice: Dice { get }
  func play()
}

protocol DiceGameDelegate {
  func gameDidStart(game: DiceGame)
  func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
  func gameDidEnd(game: DiceGame)
}


class SnakesAndLadders: DiceGame {
  let finalSquare = 25
  
  // 使用Dice class製作一個6面骰子，利用RandomNumberGenerator protocol取的隨機數值
  let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
  
  var square = 0
  var board: [Int]
  
  // 初始化每個格子，特定格子有特殊意義
  init() {
    board = [Int](count: finalSquare + 1, repeatedValue: 0)
    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
  }
  
  // 宣告delegate的變數，是一個DiceGameDelegate，用來觀察遊戲的進度
  var delegate: DiceGameDelegate?
  
  func play() {
    square = 0
    
    // 告知遊戲開始
    delegate?.gameDidStart(self)
    
    // 開始跑擲骰子的迴圈
    gameLoop: while square != finalSquare {
      let diceRoll = dice.roll()
      
      // 告知開始新的一輪擲骰子
      delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
      
      // 判斷擲骰子後的隨機數值對應的結果
      switch square + diceRoll {
      
      // 先前的格子＋走的步伐剛好抵達最後的格子，離開這個迴圈
      case finalSquare: 
        break gameLoop
        
      // 先前的格子＋走的步伐超出最後的格子，重新跑迴圈   
      case let newSquare where newSquare > finalSquare:
        continue gameLoop
        
      // 還在格子內，遊戲持續進行    
      default:
        square += diceRoll
        square += board[square]
      }
    }
    
    // 告知遊戲結束
    delegate?.gameDidEnd(self)
  }
}
 ```
 
 下方DiceGameTracker class採用DiceGameDelegate protocol，實作protocol定義的三個方法：
 ```swift
 class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}
 ```

SnakesAndLadders class instance的delegate使用了DiceGameTracker這個採用DiceGameDelegate protocol的class：
```swift
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The game lasted for 4 turns
```

<br \>
<br \>
## Adding Protocol Conformance with an Extension

為Dice額外擴充一個protocol，之後每個Dice的instance都能使用該protocol的method：
```swift
protocol TextRepresentable {
  var textualDescription: String { get }
}

extension Dice: TextRepresentable {
  var textualDescription: String {
    return "A \(sides)-sided dice"
  }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// Prints "A 12-sided dice"
```

<br \>
##### Declaring Protocol Adoption with an Extension

如果一個type本身就符合protocol的要求，那可以利用extension來採用此protocol，body就可以是空白的：
```swift
struct Hamster {
  var name: String
  
  var textualDescription: String {
    return "A hamster named \(name)"
  }
}

extension Hamster: TextRepresentable {}


let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// Prints "A hamster named Simon"
```

***Note: 即使滿足了協定的所有要求，type也不會自動轉變，因此你必須為它做出明顯的protocol宣告***

<br \>
<br \>
## Collections of Protocol Types

Protocol可以像是type一樣儲存在集合裡，如Array和Dictionary：
```swift
let things: [TextRepresentable] = [game, d12, simonTheHamster]
```

使用for loop遍歷所有項目：
```swift
for thing in things {
    print(thing.textualDescription)
}
// A game of Snakes and Ladders with 25 squares
// A 12-sided dice
// A hamster named Simon
```

<br \>
<br \>
## Protocol Inheritance

Protocol可以繼承一或多個protocols：
```swift
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}
```

一個protocol繼承另一個protocol：
```swift
protocol TextRepresentable {
  var textualDescription: String { get }
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}
```

將先前的SnakesAndLadders class使用PrettyTextRepresentable protocol，因為該protocol又繼承TextRepresentable protocol，
因此必須滿足兩個protocol的需求，也就是textualDescription及prettyTextualDescription property：
```swift
protocol PrettyTextRepresentable: TextRepresentable {
  var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable{
  
  var textualDescription: String{
    return "A game of Snakes and Ladders with \(finalSquare) squares"
  }
  
  var prettyTextualDescription: String {
    var output = textualDescription + ":\n"
    
    for index in 1...finalSquare {
      switch board[index] {
      case let ladder where ladder > 0:
        output += "▲ "
      case let snake where snake < 0:
        output += "▼ "
      default:
        output += "○ "
      }
    }
    return output
  }
}

print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○
```

<br \>
<br \>
## Class-Only Protocols

可以限制protocols只能被classes使用，將 **class** 關鍵字擺在protocol列表中的第一順位：
```swift
protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
    // class-only protocol definition goes here
}
```

***Note: 因為classes是reference type，而structures和enumerations是value type，在使用上有時候需要區分，詳細情況請看 [Classes and Structures](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Classes-and-Structures.md)***


<br \>
<br \>
## Protocol Composition

格式是 **protocol<<SomeProtocol, AnotherProtocol>SomeProtocol, AnotherProtocol>**，可以將多個protocol放在角括號裡，範例如下：
```swift
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)
// Prints "Happy birthday Malcolm - you're 21!"
```

***Note: Protocol Composition並沒有產生一個新的protocol，只是多個protocols生成一個暫時的protocol***

<br \>
<br \>
## Checking for Protocol Conformance
如 [Types Casting](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Type-Casting.md)介紹的一樣，可以用 **is** 跟 **as** 來判斷protocol conformance

Circle和Country是使用了HasArea protocol的class，而Animal是普通的class，因為三個都是class，所以可以一起放進一個叫objects的Array，當我們用迴圈是遍歷所有項目時，就能用 as? 來判斷是否有使用HasArea protocol了：
```swift
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
// Area is 12.5663708
// Area is 243610.0
// Something that doesn't have an area
```

<br \>
<br \>
## Optional Protocol Requirements

**@objc** 關鍵字是為了讓Swift跟Objective-C能互相使用，即使專案沒有任何Objective-C，還是得加上去，而在properties或是methods前加上 **optional** 關鍵字視為非必要實作的項目：
```swift
@objc protocol CounterDataSource {
  optional func incrementForCount(count: Int) -> Int
  optional var fixedIncrement: Int { get }
}

class Counter {
  var count = 0
  var dataSource: CounterDataSource?
  
  func increment() {
    if let amount = dataSource?.incrementForCount?(count) {
      count += amount
    } else if let amount = dataSource?.fixedIncrement {
      count += amount
    }
  }
}

class ThreeSource: NSObject, CounterDataSource {
  let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()

for _ in 1...4 {
  counter.increment()
  print(counter.count)
}
// 3
// 6
// 9
// 12
```

更複雜的例子：
```swift
@objc class TowardsZeroSource: NSObject, CounterDataSource {
  func incrementForCount(count: Int) -> Int {
    if count == 0 {
      return 0
    } else if count < 0 {
      return 1
    } else {
      return -1
    }
  }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()

for _ in 1...5 {
  counter.increment()
  print(counter.count)
}
// -3
// -2
// -1
// 0
// 0
```

<br \>
<br \>
## Protocol Extensions

Protocol Extensions可以擴充method和property來給使用此protocol的types，而不需要個別在每個type或是在global function定義：
```swift
protocol RandomNumberGenerator {
  func random() -> Double
}

extension RandomNumberGenerator {
  func randomBool() -> Bool {
    return random() > 0.5
  }
}

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

print("And here's a random Boolean: \(generator.randomBool())")
// Prints "And here's a random Boolean: true" (random = 0.729023776863283)
```

<br \>
##### Providing Default Implementations
用protocol extension來提供預設的實作，而當使用此protocol的type有實作property或是method時，則會取代預設的實作

***Note: 預設的實作與optional protocol requirements不同，雖然兩者都不需經過使用此protocol的type實作，但是擁有預設的實作就可以呼叫requirements而不帶optional***

PrettyTextRepresentable使用extension幫prettyTextualDescription property擴充一個預設的實作：
```swift
protocol TextRepresentable {
  var textualDescription: String { get }
}

protocol PrettyTextRepresentable: TextRepresentable {
  var prettyTextualDescription: String { get }
}

extension PrettyTextRepresentable  {
  var prettyTextualDescription: String {
    return textualDescription
  }
}
```

<br \>
##### Adding Constraints to Protocol Extensions

擴充CollectionType protocol允許任何符合TextRepresentable protocol的項目：
```swift
extension CollectionType where Generator.Element: TextRepresentable {

  var textualDescription: String {
    let itemsAsText = self.map { $0.textualDescription }
    return "[" + itemsAsText.joinWithSeparator(", ") + "]"
  }
}
```

建立三個Hamster instance，因為Hamster都有使用TextRepresentable protocol，所以都符合CollectionType的限制：
```swift
struct Hamster {
  var name: String
  var textualDescription: String {
    return "A hamster named \(name)"
  }
}

extension Hamster: TextRepresentable {}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.textualDescription)
// Prints "[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]"
```
