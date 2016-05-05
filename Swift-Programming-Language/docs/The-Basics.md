The Basics
----------


Constants and Variables
----------
***Declaring Constants and Variables***
* let: 不可改變值 , var: 可改變值
* 可以一次宣告多個值
```swift
var x = 0.0, y = 0.0, z = 0.0
let a = 1, b = 1, c = 1
```
<br \>
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
<br \>
***Naming Constants and Variables***
<br \>
逼不得已要使用保留字當常(變)數名稱時，可以使用 `` 包起來：
```swift
let `case` = "hello"
print(`case`)

// Prints: "hello"
```
<br \>
Integers
----------
* signed: 正、負、零， unsigned: 正、零
* 8, 16, 32, and 64 bit有sign和unsign，區別在於unsign前面會加U（example: Int8 -> UInt8）
```swift
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```

*Int and UInt*
* 是依照當前平台是幾位元來設定大小，假設目前平台是64位元，那Int就是Int64
* 避免數字間的轉換出現問題，盡量使用Int
```swift
let maxForInt = Int.max
let maxForInt64 = Int64.max

// The maxForInt and the maxForInt64 have same value.(My platform is 64-bit)
```

<br \>
Floating-Point Numbers
----------
* Double表示64-bit的浮點數，Float則是32-bit的浮點數
* 浮點數僅有signed
* Double精準度較高，至少有15位數，而Float最少只有6位數，所以推薦用Double

<br \>
Type Safety and Type Inference
----------
* Swift是type-safe language，所以你不應該賦與一個Int給一個宣告為String的常(變)數，也因為是type-safe，在編譯階段就會去確認是否有不合理的給值，而不會在執行的階段才出現錯誤
* 有type inference就不需明確指定type
* 浮點數永遠被推斷為Double，除非你有指定Float
* 浮點數＋整數是推斷為浮點數
```swift
let anotherPi = 3 + 0.14159
// anotherPi is also inferred to be of type Double
```

<br \>
Numeric Literals
----------
<br \>
*Integer literals*
* 十進制(decimal), with no prefix
* 二進制(binary), with a 0b prefix
* 八進制(octal), with a 0o prefix
* 十六進制(hexadecimal), with a 0x prefix
```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
```

*Floating-point literals*
* 十進制使用大小寫e來表示後方的數字是指數(1.25e2 means 1.25 x 10^2, 1.25e-2 means 1.25 x 10^-2)
* 同上，十六進制則是使用大小寫p(0xFp2 means 15 x 2^2, 0xFp-2 means 15 x 2^-2)
* 十六進制是0~9、A(10)、B(11)、C(12)、D(13)、E(14)、F(15)

下方有一樣的值12.1875([進制算法參考](https://market.cloud.edu.tw/content/vocation/business/tc_ct/ch3/3-2.htm))：

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0  // (12*16^0 + 0.3*16^-1) * 2^0 = 12.1875
```

整數和浮點數皆允許填充零或是下底線來增加可讀性：
```swift
let paddedDouble = 000123.456                 // 123.456
let oneMillion = 1_000_000                    // 1000000
let justOverOneMillion = 1_000_000.000_000_1  // 1000000.0000001
```

<br \>
Numeric Type Conversion
----------
<br \>
*Integer Conversion*
* 常(變)數在賦與整數值時，要注意其Numeric type，不能超出range及是否允許正負號
* 不同Numeric type不能直接運算，必須先經過轉換
```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

*Integer and Floating-Point Conversion*
<br \>
整數與浮點數做運算時，同樣要先轉換到一樣的type才能執行：
```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
```

浮點數也可轉換到整數（無條件捨去法）：
```swift
let pi = 3.14
let integerPi = Int(pi)  // 3
let g = 9.8
let integerG = Int(g)    // 9
```

<br \>
Type Aliases
----------
<br \>
可以定義某種type的別名，利用關鍵字typealias：
```swift
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

// maxAmplitudeFound is now 0
```

<br \>
Tuples
----------
* 最常用在function的回傳值，像回傳經緯度時，就不需刻意把兩個值用逗號隔開放在一個字串做回傳
* tuple可以包含各種type，格式是(type1,type2,...)
```swift
let http404Error = (404, "Not Found")

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"

print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
```

如果你只需要取得tuple裡的一個值，將沒用到的變數設定為 _ ：
```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

// Prints "The status code is 404"
```

可以利用index number來取得值：
```swift
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"

print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"
```

定義各種type的名稱，那取值時就可以用該名稱來取得：
```swift
let http200Status = (statusCode: 200, description: "OK")

print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"

print("The status message is \(http200Status.description)")
// Prints "The status message is OK"
```

<br \>
Optionals
----------
* 兩種情況，一種是有值那會是Optional type，一種是沒有值，表示nil
* 在Objective-C時代，nil代表是一個Object沒有值，如果是在structures、 basic C types、 enumeration values沒有值的情況下，回傳是NSNotFound，這樣我們在判斷一個value是否有值非常的不方便，Swift的Optional橫空出世了，任何沒有值的情況都會是nil
* nil無法被使用，如果有常(變)數可能是nil，那請用optional，那之後即使該常(變)數是nil也不會造成錯誤，因為之後的code會被忽略

宣告一個常(變數)為Optional時，若沒有賦與初始值，那將會自動給予一個nil的初始值：
```swift
var surveyAnswer: String?
// surveyAnswer is automatically set to nil
```

<br \>
***If Statements and Forced Unwrapping***
<br \>

可以用if來判斷常(變)數是否為nil，如果確定有值，那就能用驚嘆號來取值(forced unwrapping)，不然值會是一個Optional：
```swift
surveyAnswer = "Rocoo"
if surveyAnswer != nil {
    print("surveyAnswer has an string value of \(surveyAnswer!).")
}
// Prints "surveyAnswer has an string value of Rocoo."
```

<br \>
***Optional Binding***
<br \>
用if或while去判斷該Optional type是否為nil，如果不是那就將值暫時存放在一個常(變)數，語法如下：
```swift
if let constantName = someOptional {
    statements
}
```

actualNumber是確定Optional type有值才賦與的，所以使用時不需要加上驚嘆號 ：
```swift
let possibleNumber = "123"

if let actualNumber = Int(possibleNumber){
  print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
  print("\"\(possibleNumber)\" could not be converted to an integer")
}

// Prints ""123" has an integer value of 123"
```

if語句允許1至多個Optional Binding且可以使用一個where條件：
```swift
if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}

// Prints "4 < 42"
```

<br \>
***Implicitly Unwrapped Optionals***
<br \>
* 如果已經確定常(變)數有值的話，那直接用驚嘆號來宣告就行，那表示該常(變)數已經是unwrap的狀態，取值時當然就不用在家驚嘆號了
* Implicitly Unwrapped Optionals 同樣可以使用if句法及Optional Binding
* 假設常(變)數有可能是nil，那請使用一般的Optional來宣告
```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark
 
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark


if assumedString != nil {
    print(assumedString)
}
// Prints "An implicitly unwrapped optional string."


if let definiteString = assumedString {
    print(definiteString)
}
// Prints "An implicitly unwrapped optional string."
```

<br \>
Error Handling
----------
* 在function加上throws表示可以拋出error
* 在語法前加上try表示要攔截錯誤訊息
```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}


do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}

```

<br \>
Assertions
----------
* 用來設定某些條件，當條件不成立時會終止，在debug時非常好用
* assert如果是true則繼續運行，false則停止在那行
* 當App Release時，程式碼的assert都是停用的
```swift
let age = -3
assert(age >= 0, "A person's age cannot be less than zero")

// this causes the assertion to trigger, because age is not >= 0
```
<br \>
***When to Use Assertions***
* An integer subscript index is passed to a custom subscript implementation, but the subscript index value could be too low or too high.
* A value is passed to a function, but an invalid value means that the function cannot fulfill its task.
* An optional value is currently nil, but a non-nil value is essential for subsequent code to execute successfully.








