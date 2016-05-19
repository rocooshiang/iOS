Collection Types
----------

* Array: 有順序性
* Set: 沒有順序性
* Dictionary: 沒有順序性，藉由Key-Value來取得資料
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Collection%20Type1.png)
<br \>
[(圖片轉自The Swift Programming Language , Collection Types)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

Mutability of Collections
----------
* 建立Arrays、Set和Dictionaries後，可以任意更改長度及成員
* 如果設定是常數，那將無法改變上方敘述

Arrays
----------
**Array Type Shorthand Syntax**
* 建立Array有兩種方式，Array\<Element\>  or [Element] ，首推[Element]
<br \>

建立Empty Array：
```swift
var someInts = [Int]()
```

如果Array先前已經知道type，那之後要建立Empty Array只需要使用 [ ]
```swift
someInts.append(3)
// someInts now contains 1 value of type Int
someInts = []
// someInts is now an empty array, but is still of type [Int]
```



**Creating an Array with a Default Value**
<br \>
設定成員數量及值來建立Array：
```swift
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
```

**Creating an Array by Adding Two Arrays Together**
<br \>
加總兩個已存在的Array也可以建立新的Array，用+號連接(但是要同樣type的Array)：
```swift
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
 
var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```

**Creating an Array with an Array Literal**
<br \>
直接在中括號放入初始話的值，而:[String]表示這個Array的值限定是String：
```swift
var shoppingList: [String] = ["Eggs", "Milk"]
```

因為Swift藉由值來推斷其Type，所以更簡潔的寫法：
```swift
var shoppingList = ["Eggs", "Milk"]
```

**Accessing and Modifying an Array**
```swift
shoppingList.count 
// 計算shoppingList的成員數量

shoppingList.isEmpty
// 判斷shoppingList是否有成員(count == 0 is true)
```

新增成員，從Array已存在的最後一個成員後開始加入：
```swift
shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes

shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items

shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items
```

可以用range的方式設定新的值，即使新的值與range的數量不一致：
```swift
shoppingList[4...6] = ["Bananas", "Apples"]
// "Eggs","Milk","Flour","Baking Powder","Bananas","Apples"
```

利用index新增刪除值：
```swift
shoppingList.insert("Maple Syrup", atIndex: 0)

shoppingList.removeAtIndex(0)
```

要刪除最後一個index的值時：
```swift
shoppingList.removeLast()
```

**Iterating Over an Array**
<br \>

取得index與value：
```swift
for (index, value) in shoppingList.enumerate() {
    print("Item \(index + 1): \(value)")
}
// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas
```

<br \>
Sets
----------
* 會過濾相同的值，所以每個值都是唯一，不會重複
* 語法是Set<Element>，不像Array有簡寫

**Creating and Initializing an Empty Set**
```swift
var letters = Set<Character>()
```

若是Set已經知道type了，那也可以使用 [ ]來初始化：
```swift
letters.insert("a")
// letters now contains 1 value of type Character
letters = []
// letters is now an empty set, but is still of type Set<Character>
```

直接用Array裝值來初始化Set：
```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
```

因為Swift可以推斷type，所以簡寫：
```swift
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
```

**Accessing and Modifying a Set**
<br \>
利用contains確認某些值是否存在：
```swift
favoriteGenres.contains("Funk")
// false
```

**Iterating Over a Set**
<br \>
Set沒有排序，但是有sort()這個方法可以依照字母順序或是數字大小來做排序：
```swift
for genre in favoriteGenres.sort() {
    print("\(genre)")
}
// Classical
// Hip hop
// Jazz
```

<br \>
Performing Set Operations
----------
**Fundamental Set Operations**
<br \>
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Collection%20Type2.png)
<br \>
[(圖片轉自The Swift Programming Language , Collection Types)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

* 交集：intersect （A∩B）
* 獨立：exclusive
* 聯集：union (A∪B)
* 差集：subtract (A−B)

```swift
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
 
oddDigits.union(evenDigits).sort()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersect(evenDigits).sort()
// []
oddDigits.subtract(singleDigitPrimeNumbers).sort()
// [1, 9]
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()
// [1, 2, 9]
```

**Set Membership and Equality**
* a.isSubsetOf(b)： 確定Set a的值是否在Set b都存在
* a.isSupersetOf(b)： 確定Set b擁有的值，Set a也都擁有
* a.isDisjointWith(b)： 判斷Set a與Set b是否有任何值一樣
```swift
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubsetOf(farmAnimals)
// true
farmAnimals.isSupersetOf(houseAnimals)
// true
farmAnimals.isDisjointWith(cityAnimals)
// true
```

<br \>
Dictionaries
----------
<br \>

**Dictionary Type Shorthand Syntax**
<br \>
Dictionary<Key, Value> or [Key: Value]，首選是[Key: Value]

**Creating an Empty Dictionary**
```swift
var namesOfIntegers = [Int: String]()
```

如果已經知道Dictionary的type，可以使用 [ : ]來建立Empty的Dictionary：
```swift
namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]
```

**Creating a Dictionary with a Dictionary Literal**
```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

因為Swift的推斷，所以可以簡寫：
```swift
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```
 
**Accessing and Modifying a Dictionary**
<br \>
使用Key來新增Dictionary成員，也可以利用Key來更改對應的值：
```swift
airports["LHR"] = "London"

airports["LHR"] = "London Heathrow"
```

利用Key刪除一組Key-Value：
```swift
airports["APL"] = "Apple International"
// "Apple International" is not the real airport for APL, so delete it
airports["APL"] = nil
// APL has now been removed from the dictionary
```

**Iterating Over a Dictionary**
```swift
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
```

只檢視Key或Value：
```swift
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

```

建立Key或Value的Array(Dictionary沒有順序性，所以每次建立的Array成員順序會不一樣)：
```swift
let airportCodes = [String](airports.keys)
// airportCodes is ["YYZ", "DUB", "LHR"]
 
let airportNames = [String](airports.values)
// airportNames is ["Toronto Pearson", "Dublin" , "London Heathrow"]
```
