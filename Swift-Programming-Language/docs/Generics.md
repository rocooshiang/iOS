# Generics

<br \>
<br \>
## The Problem That Generics Solve

下方是三個種兩type的值互換，可是其實整個function就只有輸入的parameter type不一樣，
內容都相同，為了解決重複寫的一樣的code，所以Generics出來拯救我們了：
```swift
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}
 
func swapTwoDoubles(inout a: Double, inout _ b: Double) {
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

***Note: 兩個互換的值的type一定要一樣，因為Swift是type-safe language，所以當你嘗試兩個不一樣type的值互換時，
會發生compile-time error***

<br\ >
<br \>
## Generic Functions
使用 **T** 來取代明確標示哪種type(Int,Double或是String)， **```<T>```** 是用來告訴Swift，我function裡有 **T** 這個placeholder type name，
Swift就不會去查詢它的明確type，以下是比較：
```swift
func swapTwoInts(inout a: Int, inout _ b: Int)
func swapTwoValues<T>(inout a: T, inout _ b: T)
```

使用Generic將之前三種function合併成一個：
```swift
func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3
 
var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"
```

***Note: Swift本身就有提供method(``` swap(_:_:) ```)來交換相同type的值，所以不用再特別自訂以上方法了***

<br \>
<br \>
## Naming Type Parameters
很多時候會幫placeholder type name取有意義的名稱，像是 Key 和 Value 在 Dictionary<Key, Value>，
或是Element 在 Array<Element>，讓使用者清楚的知道它們的關係

***Note: 記得字首使用大寫來表示placeholder type name***

<br \>
<br \>
## Generic Types
***Note:  Stack概念是後進先出(Last in, First out)，UINavigationController 就是以這樣的概念去控制多個 view controllers，
使用```pushViewController(_:animated:)```method來新增一個 view controller 到 navigation stack，然後使用```popViewControllerAnimated(_:)``` method
來從 navigation stack 移除一個 view controller***

![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Generics1.png)
<br \>
[(圖片轉自The Swift Programming Language , Generics)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)

<br \>
non-generic 的 stack，僅能使用 Int：
```swift
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
```

generic 的 stack，可以使用任何 type:
```swift
struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
```

使用剛剛定義的 generic version stack：
```swift
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings
```

![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Generics2.png)
<br \>
[(圖片轉自The Swift Programming Language , Generics)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)

<br \>
從 stack 刪除(popping)一個值，因為是後進先出(last in, first out)，所以 **"cuatro"** 會被刪除：
```swift
let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings
```

![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Generics3.png)
<br \>
[(圖片轉自The Swift Programming Language , Generics)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)

<br \>
<br \>
## Extending a Generic Type

不需要在 extension generic type 時提供 type parameter，因為可以使用原本定義的type parameter(Element)，下方是
新增一個 read-only 的 computed property 叫 topItem ，可以查詢誰是最頂端(最後加入)的 value：
```swift
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
```

現在可以使用擴充的 topItem computed property：
```swift
if let topItem = stackOfStrings.topItem {
  print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."
```

<br \>
<br \>
## Type Constraints
有時候限制 generics type 可以幫助我們做很多事情，像你可以指定是繼承來自某個 class ，或是符合某些 protocol。
舉個例子，Swift 的 **Dictionary** 的 generics type 就有設下某些限制， key 必須是可以被 hashable，目的是用來
判斷這個 key 在 Dictionary 是獨一無二的，這樣後續才能利用這個 key 來判斷是要新增還是取代，所以 key 使用 Hashable protocol
，所有 basic types 都有使用這個 protocol（如 String, Int, Double, Bool）。

<br \>
##### Type Constraint Syntax

以下例子 T 必須是 SomeClass 的 subclass ， 而 U 必須使用 SomeProtocol：
```swift
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}
```

<br \>
##### Type Constraints in Action

下方定義了一個從 array 找某個 string 的 index ，使用 non-generics function：
```swift
func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print("The index of llama is \(foundIndex)")
}
// Prints "The index of llama is 2"
```

Generics version function：
```swift
func findIndex<T>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
```

下方是改良上方的程式，因為不是任何 type 都能用來比較的(==)，所以為了避免出錯，
我們限制只有遵循 Equatable protocol 的 type (```<T: Equatable>```) 才能使用 ```findIndex(_:_:)``` 這個 method ，
因為遵循這個 protocol 的 type 保證是可以比較的：
```swift
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
// doubleIndex is an optional Int with no value, because 9.3 is not in the array

let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
// stringIndex is an optional Int containing a value of 2
```

<br \>
<br \>
## Associated Types

##### Associated Types in Action

一個叫 Container 的 protocol，宣告一個叫 ItemType 的 associated type：
```swift
protocol Container {
  associatedtype ItemType
  mutating func append(item: ItemType)
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
}
```

Non-generics：
```swift
struct IntStack: Container {
  // original IntStack implementation
  var items = [Int]()
  
  mutating func push(item: Int) {
    items.append(item)
  }
  
  mutating func pop() -> Int {
    return items.removeLast()
  }
  
  // conformance to the Container protocol
  typealias ItemType = Int
  mutating func append(item: Int) {
    self.push(item)
  }
  
  var count: Int {
    return items.count
  }
  
  subscript(i: Int) -> Int {
    return items[i]
  }
}
```

Generics：
```swift
struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    mutating func append(item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}
```

<br \>
##### Extending an Existing Type to Specify an Associated Type
Swift 的 Array 已經有提供 ```append(_:)``` method，count property，還有一個可以輸入 index 可以回傳成員的
subscript，以上已經滿足了 Container protocol 的要求，所以可以實作一個 empty extension：
```swift
extension Array: Container {}
```

<br \>
<br \>
## Where Clauses

以下用 where 語句來判斷兩個 Container 的 type 是否相等：
```swift
func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // all items match, so return true
    return true
    
}
```

因為兩個都是 stackOfStrings 跟 arrayOfStrings 都是 String type，且都是能比較的，所以可以使用
```allItemsMatch(_:_:)``` method：

```swift
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings, arrayOfStrings) {
  print("All items match.")
} else {
  print("Not all items match.")
}
// Prints "All items match."
```

