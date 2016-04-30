The Swift Tour
----------------
Print用法
```swift
let name = "Rocoo"
print("Hello, \(name)")
print("Hello, "+name)
print("Hello, Rocoo")
print("Hello, "+"Rocoo")

// Prints "Hello, Rocoo"
```

Simple Values
----------
let: 常數 ， var: 變數

- 不需明確宣告type，Compiler會自動推斷
- 如果沒有提供足夠的訊息，那就必須指定type

如果不指定myValue為Double，那會被推斷為Integer：
```swift
let myValue : Double = 70

// myValue is 70.0
```

Swift不會自動幫你轉type，必須手動(不像Java可以String + Int = String)：
```swift
let label = "Rocoo age is "
let age = 26
let ageLabel = label + String(age)
```
or
```swift
let ageLabel = "\(label)(age)"
```

建立Array： 
```swift
var peopleList = ["Irving", "Rocoo", "Curry"]
peopleList[1] = "Rose"

// peopleList: "Irving, Rose, Curry"
```

建立Dictionary：
```swift
var nbaStars = [
  "West": "Kobe",
  "East": "Iversion",
  "North": "Carter",
]
```

新增Key-Value：
```swift
nbaStars["South"] =  "Mcgrady"

// "West": "Kobe" , "East": "Iversion" ,"North": "Carter","South": "Mcgrady"
```

取代既有的Value：
```swift
nbaStars["West"]  = "Curry"

// "West": "Curry" , "East": "Iversion" ,"North": "Carter","South": "Mcgrady"
```

建立空的Array與Dictionary：
```swift
let emptyArray = [String]()
let emptyDictionary = [String: String]()
```

如果有足夠的資訊可以推斷出該常數或變數是什麼type，可以使用：
```swift
peopleList = []
nbaStars = [:]
```


Control Flow
----------
迴圈條件的小括號可有可無：
```swift
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0

for score in individualScores {
  teamScore += score
}
```

當宣告的變數是optional時，可以利用if let去判斷該變數是否為nil：
```swift
var optionalName: String? = "Rocoo"

if let name = optionalName {
  print("The optionalName isn't nil")
}else{
  print("The optionalName is nil")
}

// Prints "The optionalName isn't nil" 
```

當optional的變數值是nil，可以使用??來賦予新值：
```swift
let nickName: String? = nil
let fullName: String = "Rocoo"
let informalGreeting = "Hi \(nickName ?? fullName)"

// Prints "Hi Rocoo"
```
Switch:
- 提供各式各樣的比較，不侷限在值與值的比對
- 下方case的where類似SQLite的where，用來設定某些條件
- 每個case後不需要加上break，因為當有case符合條件則Switch就結束了
- default關鍵字是一定要出現的
```swift
let vegetable = "red pepper"
switch vegetable {
case "celery":
  print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
  print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
  print("Is it a spicy \(x)?")
default:
  print("Everything tastes good in soup.")
}

// Prints "Is it a spicy red pepper?"
```

for-in使用來遍歷所有對象的成員，如Dictionary，然而Dictionary是不按排序的集合，
所以取出來的成員先後順序無從得知：
```swift
let interestingNumbers = [
  "Prime": [2, 3, 5, 7, 11, 13],
  "Fibonacci": [1, 1, 2, 3, 5, 8],
  "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
  for number in numbers {
    if number > largest {
      largest = number
    }
  }
}
// The "kind" is key and the "numbers" is value.
// The largest value is 25.
```

while用來重複執行body，直到條件不成立：
```swift
var n = 2
while n < 100 {
  n = n * 2
}

var m = 2
repeat {
  m = m * 2
} while m < 100
```

也可以使用...或是..<當做條件判斷，差別在於...有包括後面的條件，..<則沒有：
```swift
var peopleList = ["Irving", "Rose", "Curry"]

for index in 0..<peopleList.count{
  print(peopleList[index])
}

// Irving ...
// Rose ...
// Curry
```

Functions and Closures
-----------
function:
- 可以回傳1個或多個不同type的回傳值，多個稱為tuple
- 參數可以使用...表示有多個，在function裡面會以Array的方式呈現(注意: ...在一個function的參數列裡只能出現一次)
```swift
func gameWinner(players: [String] , scores: Int...) -> (winner: String, score: Int){
  
  var indexOfWinner = 0
  
  for index in 0..<scores.count-1{
    
    if scores[index]<scores[index+1]{
      
      indexOfWinner = index+1
      
    }
    
  }
  
  return(players[indexOfWinner],scores[indexOfWinner])
}

let game = gameWinner(["Irving","Curry","Rose"], scores: 97,96,92)
print("\(game.winner) got \(game.score) points.")

// Prints: "Irving got 97 points."
```

巢狀function：
```swift
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
```

function回傳的type也可以是個function：
```swift
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
```

function的參數也可以是一個function：
```swift
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, condition: lessThanTen)
```

Closure：
- 寫Closure用 ({}) 包起來
- in是用來分開arguments與來自body的return type
```swift
let numbers = [20, 19, 7, 12]

let originalMappedNumbers = numbers.map ({(number: Int) -> Int in
  return number % 2 == 1 ? 0 : number
})

print(originalMappedNumbers)

// Prints: "[20, 0, 0, 12]"
```

如果已經知道Closure的type(numbers傳進去的值一定是Int)，那參數與回傳值的type都可以省略不寫，回傳的關鍵字return也可省略：
```swift
let shorthandMappedNumbers = numbers.map({ number in number % 2 == 1 ? 0 : number })
```

如果Closure是作為function的唯一參數，那可以更精簡：
```swift
let simplestMappedNumbers  = numbers.map{ $0 % 2 == 1 ? 0 : $0}
```

Objects and Classes
-----------

Class:
- init的function是初始化一些值，一個class可以有多個不同參數的init function，也可以一個都沒有(那屬性的初始值在宣告時就要賦與)
- 一定要賦與所有參數初始值，可以宣告時給值，或是在init裡給
- self是區隔參數與class的屬性
- deinit是在該物件要被釋放前會被呼叫的，可以清掉妳不要的東西
```swift
class Introduction {  
  var name: String
  var age: Int = 18
  
  init(name: String) {
    self.name = name
  }
  
  init(name: String,age: Int) {
    self.name = name
    self.age = age
  }
  
  deinit{
    self.name = "Bye Bye"
    self.age = 0
  }
  
  func simpleDescription() -> String {
    return "My name is \(name)."
  }
}

let rocoo = Introduction(name: "Rocoo")
let irving = Introduction(name: "Irving", age: 26)
```

SubClass:
- init function呼叫super.init前，一定要先賦與值給SubClass的所有屬性(順序顛倒會錯誤，猜測應該是呼叫super.init後，SubClass就正式被初始化，那在前面提過，每個Class的屬性一定要賦與初始值，為了確保這點，所以不能顛倒)，最後才能賦與SuperClass的屬性值
- SubClass覆寫SuperClass的方法，一定要用override關鍵字

init順序 懶人包：
  1. 賦與subClass的所有屬性值 
  2. 初始化superClass 
  3. 賦與superClass屬性值 
```swift
class MoreIntroduction : Introduction{
  var starSide : String
  
  init(name: String,starSide: String){
    self.starSide = starSide  //1
    super.init(name: name)  //2
    age = 26  //3
  }
  
  override func simpleDescription() -> String {
    return "My name is \(name), the star side is \(starSide)."
  }
  
}

let rocoo = MoreIntroduction(name: "Rocoo", starSide: "Aquarius")
rocoo.simpleDescription()

// Prints: "My name is Rocoo, the star side is Aquarius."
```

SubClass如果寫自己的init function，那想用SuperClass的init function，就要覆寫並加上override，若是沒有寫自己的init function，那可以直接沿用，屬性如需經過一些計算才能給值，那可以設定set與get來讓其他人取得，在set可以設定新值的參數名稱，或是使用內建的newValue：
```swift
class OtherIntroduction : Introduction{
  
  var doubleAge : Int{
    set{
      age = newValue / 2
    }
    get{
      return age * 2
    }
  }
  
}

let rocoo = OtherIntroduction(name: "Rocoo", age: 26)
rocoo.doubleAge

// 52

rocoo.age = 30
rocoo.doubleAge

// 60
```

willSet是當class屬性值有改變時會被呼叫的：
```swift
class ClassA{
  var a : Int
  init(a: Int){
    self.a = a
  }
}

class ClassB{
  var b : Int
  init(b: Int){
    self.b = b
  }
}

class ClassC{
  
  var classA: ClassA{
    willSet{
      classB.b = newValue.a
    }
  }
  
  var classB: ClassB{
    willSet{
      classA.a = newValue.b
    }
  }
  
  init(value: Int){
    classA = ClassA(a: value)
    classB = ClassB(b: value)
  }
  
}

let classC = ClassC(value: 10)
classC.classA.a
classC.classB.b

// 10
// 10

classC.classA = ClassA(a: 20)
classC.classB.b

// 20

```

class也可以設定optional，如果取到的是nil，那?之後的code都會被忽略，反之則自動unwrap：
```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

Enumerations and Structures
----------
Enumerations:
- enum預設rawValue從0開始遞增，也可以自己定義
- 可以使用init?(rawValue:)來初始化enum的成員，以下放例子而言，Rank(rawValue: 7)等於Rank.Seven
```swift
enum Rank: Int {
  case Ace = 1
  case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
  case Jack, Queen, King
  
  func campareTo(valueB: Rank) -> String{
    if self.rawValue > valueB.rawValue{
      return "\(self) > \(valueB)"
    }else{
      return "\(self) < \(valueB)"
    }
  }
  
}

let jack = Rank.Jack
let king = Rank.King
print(king.campareTo(jack))

// Prints: "King > Jack"
```

在宣告hearts時，因為常數沒辦法明確指定是哪種type，所以要完整的寫出Suit.Hearts，在swith之所以可以縮寫.Hearts是因為確定self一定是一個Suit的值：
```swift
enum Suit {
  case Spades, Hearts, Diamonds, Clubs
  
  func color() -> String{
    switch self {
    case .Spades, .Clubs:
      return "black"
    case .Diamonds, .Hearts:
      return "red"
    }
  }
  
}

let hearts = Suit.Hearts
hearts.color()

// red
```

Structure:
- struct與class類似，最重要的差異性是，struct是call by value，class則是call by reference
- struct在初始化時，會依照結構裡，變數的順序來設定參數的先後順序
```swift
struct Card {
  var rank: Rank
  var suit: Suit
  
  func simpleDescription() -> String{
    return "\(suit) \(rank.rawValue)"
  }
  
}

let card = Card(rank: .Ace, suit: .Spades)
print(card.simpleDescription())

// Prints: "Spades 1"
```

enum case可以賦與多個關聯值，關聯值與rawValue是不同的：
```swift
enum ServerResponse {
  case Result(String, String)
  case Failure(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Failure("Out of cheese.")

switch success {
case let .Result(sunrise, sunset):
  print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .Failure(message):
  print("Failure...  \(message)")
}

// Prints: "Sunrise is at 6:00 am and sunset is at 8:09 pm."
```

Protocols and Extensions
----------
Protocols:
- Protocol可以被classes, enumerations, structs採用
- method設定mutating關鍵字是為了讓遵循該protocol的enumerations和structs可以在此method修改其變數，因為class原本就能在method修改變數了，所以也不用特別加上
```swift
protocol ExampleProtocol {
  var simpleDescription: String { get }
  mutating func adjust()
}

class SimpleClass: ExampleProtocol {
  var simpleDescription: String = "A simple class"
  var anotherProperty: Int = 123
  func adjust() {
    simpleDescription += " (adjusted)"
  }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

// Prints: A simple class (adjusted)


struct SimpleStructure: ExampleProtocol {
  var simpleDescription: String = "A simple structure"
  mutating func adjust() {
    simpleDescription += " (adjusted)"
  }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

// Prints: A simple structure (adjusted)


enum SimpleEnumeration : ExampleProtocol{
  case Original, Adjust
  
  var simpleDescription: String{
    get{
      return getDescription()
    }
  }
  
  func getDescription() -> String{
    switch self{
    case .Original:
      return "A simple enumeration"
    case .Adjust:
      return "A simple enumeration (adjusted)"
    }
  }
  
  mutating func adjust() {
   self = SimpleEnumeration.Adjust
  }
}

var c = SimpleEnumeration.Original
c.adjust()
let cDescription = c.simpleDescription

// Prints: "A simple enumeration (adjusted)"
```

extension關鍵字是擴充的意思，像是如果你常使用UIAlertController來顯示上傳成功或失敗，那可以擴充UIViewController來將controller及action定義好，那就不用每次都寫一堆code了：
```swift
extension UIViewController {
  
  func showAlert(title: String, message: String?, buttonText: String) {
    
    let controller  = UIAlertController(title: title, message: message ?? nil, preferredStyle: .Alert)
    
    let action = UIAlertAction(title: buttonText, style: .Default, handler: nil)
    
    controller.addAction(action)
    
    self.presentViewController(controller, animated: true, completion: nil)
  }
  
}

```

Error Handling
-----------
- 可以自定error type來明確指出是什麼錯誤，或是只擷取預設error
- 在參數列後方加上 throws 表示該function可以丟出error
- 使用do...catch，在do裡面將要擷取error的code前面放try

```swift 
enum PrinterError: String, ErrorType {
  case OutOfPaper
  case NoToner
  case OnFire = "There is fire."
}

func sendToPrinter(printerName: String) throws -> String {
  
  switch printerName{
  case "OutOfPaper":
    throw PrinterError.OutOfPaper
  case "NoToner":
    throw PrinterError.NoToner
    case "Fire":
    throw PrinterError.OnFire
  default :
    return printerName
  }
}


do {
  let printerResponse = try sendToPrinter("Fire")
  print(printerResponse)
} catch PrinterError.OnFire {
  print(PrinterError.OnFire.rawValue)
} catch let printerError as PrinterError {
  print(printerError)
} catch {
  print(error)
}

// Prints: "There is fire."
```

使用try?也可以攔截error，如果回傳是一個nil代表有error，反之則無且該值是一個optional
```swift
let printerSuccess = try? sendToPrinter("Hello, Rocoo")
let printerFailure = try? sendToPrinter("Fire")

// nil
// Prints: "Hello, Rocoo"
```

Generics
--------
- 使用角括號來宣告泛型type，放在名稱與參數列中間
- 泛型可以是用在methods, classes, enumerations, structures
```swift
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] {
  var result = [Item]()
  for _ in 0..<numberOfTimes {
    result.append(item)
  }
  return result
}
repeatItem("knock", numberOfTimes:4)


enum OptionalValue<Wrapped> {
    case None
    case Some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

```
