# Subscripts

<br \>
<br \>
## Subscript Syntax

* 使用**subscript**關鍵字來建立一個subscript，與methods一樣可以有一個或多個parameters
* 與methods不同的地方是，subscript可以限制read only或是read-write
* Setter有default parameter叫newValue，不一定要自訂parameter name
* 如果是read only，那可以捨棄get{ }，直接return就好

read-write subscript:
```swift
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
    }
    set(newValue) {
        // perform a suitable setting action here
    }
}
```

read only subscript:
```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"
```

<br \>
<br \>
## Subscript Usage
**Dictionary**就有實作subscript藉由Key去設定和接收Value：
```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
```

***Note: 以上例子numberOfLegs["bird"]會回傳一個Int?，因為要避免找不到Key而回傳nil***
