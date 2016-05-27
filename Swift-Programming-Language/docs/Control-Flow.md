# Control Flow
<br \>
<br \>

# Conditional Statements
**If**
<br \>
多個if條件成立，那只會跑第一個scope：
```swift
let temperature = 27

if temperature >= 10 {
  print("First scope")
} else if temperature >= 22 {
  print("Second scope")
} else {
  print("Third scope")
}
// Prints "First scope"
```

**Switch**
* 每個case的scope不用特地加break
* 每個case的scope不能是空的，一定要執行一些code
* 假設有多個case符合條件，那只會執行第一個，後續都會被忽略

**Interval Matching**
<br \>
case提供範圍的比對條件：
```swift
let number = 12

switch number {
case 0:
  print("0")
case 1..<5:
  print("1~5")
case 5...12:
  print("5~12")
default:
  print("No match any condiction")
}
// Prints "5~12"
```

**Tuples**
* 下底線(_)用來match任何值
* Tuple裡的每個值，可以用一個範圍來表示
```swift
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
// Prints "(1, 1) is inside the box"
```

**Value Bindings**
<br \>
以下第一個case的條件是表示符合座標y=0的任何座標，則把它的x座標與常數x做binding，而這個例子不需要default是因為case let (x, y) 可以符合任何條件了：
```swift
let anotherPoint = (2, 0)

switch anotherPoint {
case (let x, 0):
  print("on the x-axis with an x value of \(x)")
case (0, let y):
  print("on the y-axis with a y value of \(y)")
case let (x, y):
  print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"
```

**Where**
<br \>
可以用where來增加而外的條件：
```swift
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// Prints "(1, -1) is on the line x == -y"
```
