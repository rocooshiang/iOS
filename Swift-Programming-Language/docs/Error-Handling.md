# Error Handling

<br \>
<br \>
## Representing and Throwing Errors

enumerations非常適合用來整理一組相關Error type：
```swift
enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}
```

藉由**throw**關鍵字，丟出定義在enumerations的error：
```swift
throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)
```

<br \>
<br \>
## Handling Errors
<br \>

##### Propagating Errors Using Throwing Functions

利用**throws**關鍵字來定義一個function, method, initializer可以丟出error，如下，是一個function，將throws放在箭頭的前面：
```swift
func canThrowErrors() throws -> String
 
func cannotThrowErrors() -> String
```

***Note: 只有Throwing Functions可以傳遞error，其他發生在非Throwing Functions的error，都必須處理這個function***
<br \>

利用上面的Errors來寫一個販賣機的例子：
```swift
struct Item {
  var price: Int
  var count: Int
}

class VendingMachine {
  var inventory = [
    "Candy Bar": Item(price: 12, count: 7),
    "Chips": Item(price: 10, count: 4),
    "Pretzels": Item(price: 7, count: 11)
  ]
  
  var coinsDeposited = 0
  func dispenseSnack(snack: String) {
    print("Dispensing \(snack)")
  }
  
  func vend(itemNamed name: String) throws {
    
    // 判斷販賣機有沒有賣此項目
    guard let item = inventory[name] else {
      throw VendingMachineError.InvalidSelection
    }
    
    
    // 判斷此項目售完了沒
    guard item.count > 0 else {
      throw VendingMachineError.OutOfStock
    }
    
    
    // 判斷金額是否足夠
    guard item.price <= coinsDeposited else {
      throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
    }
    
    coinsDeposited -= item.price
    
    var newItem = item
    newItem.count -= 1
    inventory[name] = newItem
    
    dispenseSnack(name)
  }
}
```

使用上方throwing function，所以在 vendingMachine.vend 前加上try：
```swift
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
```

Throwing initializers的用法與throwing funcitons相同：
```swift
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
```

<br \>
##### Handling Errors Using Do-Catch

語法：

![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Error%20Handling1.png)
<br \>
[(圖片轉自The Swift Programming Language , Error Handling)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID508)


下方延續先前的例子，金幣8，要買金幣10的Chips會丟出金額不足的error，然後藉由catch來處理error：
```swift
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
  try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
  print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
  print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
  print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."
```

<br \>
##### Converting Errors to Optional Values

小例子：
```swift
func someThrowingFunction() throws -> Int {
    // ...
}
 
let x = try? someThrowingFunction()
 
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
```

在data取得來源有很多種方式的情況下，可以用以下方法來寫：
```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```

<br \>
##### Disabling Error Propagation

使用**try!**關鍵字來表示執行過程一定不會丟出error，直接將Optional value force-wrapping：
```swift
let photo = try! loadImage("./Resources/John Appleseed.jpg")
```

<br \>
<br \>
## Specifying Cleanup Actions

關鍵字**defer**，用來確保執行某些code後，被定義在defer裡的code一定會被執行，不管是因為拋出error，或是**return**,**break**，如下例子，可以使用defer來確定文件被關閉：
```swift
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        
        defer {
            close(file)
        }
        
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
```

***Note: 你也可使用defer語句，即使這段程式碼裡沒有任何處理error的code***
