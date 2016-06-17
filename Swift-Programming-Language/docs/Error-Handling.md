# Error Handling

<br \>
<br \>
## Representing and Throwing Errors

enumerations非常適合用來整理一組相關Error type：
```swift
enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}
```

藉由**throw**關鍵字，丟出定義在enumerations的error：
```swift
throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)
```

<br \>
<br \>
## Handling Errors
<br \>

##### Propagating Errors Using Throwing Functions

利用**throws**關鍵字來定義一個function, method, initializer可以丟出error，如下，是一個function，將throws放在箭頭的前面：
```swift
func canThrowErrors() throws -> String
 
func cannotThrowErrors() -> String
```

***Note: 只有Throwing Functions可以傳遞error，其他發生在非Throwing Functions的error，都必須處理這個function***

