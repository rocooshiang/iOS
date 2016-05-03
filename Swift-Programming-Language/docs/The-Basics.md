The Basics
----------
<br \>
<br \>
<br \>

Constants and Variables
----------
***Declaring Constants and Variables***

let: 不可改變值 , var: 可改變值

可以一次宣告多個值：
```swift
var x = 0.0, y = 0.0, z = 0.0
let a = 1, b = 1, c = 1
```

***Type Annotations***
* 可以先宣告類型，之後在賦與值(常數只能給一次值)
* 下方name與name2就不是靠初始值推斷type，而是藉由type annotation
```swift
let name: String
name = "Rocoo"

var name2: String
name2 = "Irving"
name2 = "Iversion"
```

在一行宣告多個常數or變數：
```swift
let red, green, blue: Double
var orange, black, white: Float
```

***Naming Constants and Variables***

逼不得已要使用保留字當常(變)數名稱時，可以使用 `` 包起來：
```swift
let `case` = "hello"
print(`case`)

// Prints: "hello"
```


