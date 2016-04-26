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

