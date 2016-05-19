Collection Types
----------

* Arrays: 有順序性
* Set: 沒有順序性
* Dictionaries: 沒有順序性，藉由Key-Value來取得資料
![Xcode indent settings](https://github.com/rocooshiang/LearningSwiftRecord/blob/master/Swift-Programming-Language/docs/Screenshot/Collection%20Type1.png)
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
Dictionaries
----------



