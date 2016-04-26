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

如果不指定myValue為Double，那會被推斷為Integer:
```swift
let myValue : Double = 70
// myValue is 70.0
```

Swift不會自動幫你轉type，必須手動(不像Java可以String + Int = String):
```swift
let label = "Rocoo age is "
let age = 26
let ageLabel = label + String(age)
```
or
```swift
let ageLabel = "\(label)(age)"
```

建立Array: 
```swift
var peopleList = ["Irving", "Rocoo", "Curry"]
peopleList[1] = "Rose"
// peopleList: "Irving, Rose, Curry"
```

建立Dictionary:
```swift
var nbaStars = [
  "West": "Kobe",
  "East": "Iversion",
  "North": "Carter",
]
```

新增Key-Value:
```swift
nbaStars["South"] =  "Mcgrady"
// "West": "Kobe" , "East": "Iversion" ,"North": "Carter","South": "Mcgrady"
```

取代既有的Value:
```swift
nbaStars["West"]  = "Curry"
// "West": "Curry" , "East": "Iversion" ,"North": "Carter","South": "Mcgrady"
```

建立空的Array與Dictionary:
```swift
let emptyArray = [String]()
let emptyDictionary = [String: String]()
```

如果有足夠的資訊可以推斷出該常數或變數是什麼type，可以使用:
```swift
peopleList = []
nbaStars = [:]
```





