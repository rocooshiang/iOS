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

如果不指定myValue為Double，那會被推斷為Integer
```swift
let myValue : Double = 70
// myValue is 70.0
```

Swift不會自動幫你轉type，必須手動(不像Java可以String + Int = String)
```swift
let name = "Rocoo"
let age = 26
let rocooAge = name + String(age)
```
or
```swift
let rocooAge = "\(name)(age)"
```
