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


# Control Transfer Statements
**Break**
<br \>
break可以直接跳出整個switch，從switch的}之後的第一行開始執行，當default沒有預設要做什麼時，就可以用break：
```swift
let number = 13

switch number {
case 0:
  print("0")
case 1..<5:
  print("1~5")
case 5...12:
  print("5~12")
default:
  break
}
```

**Fallthrough**
* 因為Swift的switch每個case預設break的功能，也就是說，如果你想要貫穿兩個case(或是default case)，那就要在第一個case加入關鍵字fallthrough
* 一個fallthrough只能串連兩個case，如果想要串連多個case，那就要額外加上fallthrough
* 用fallthrough只會單純去串連下一個case，並不會在去判斷下個case的條件!!
```swift
let integerToDescribe = 5
var description = "Hi"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
  description += " Rocoo "
  fallthrough
  
case 2:
  description += "AAA"
  
case 3:
  description += "BBB"
  
default:
  break
}
print(description)
// Prints "Hi Rocoo AAA"
```

**Labeled Statements**
<br \>
labeled statements與break或continue的搭配使用，下方例子其實continue不需指定gameLoop，因為只有一個迴圈：
```swift  
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
```

**Early Exit**
<br \>
設定條件，如果不符合則不繼續之後的動作：
```swift
func checkNumber(number: Int){
  if number <= 5{
    return
  }
  print("\(number) >= 5")
  
  if number <= 10{
      return
  }
  print("\(number) >= 10")
}

checkNumber(9)
// Prints: "9 >= 5"
```


