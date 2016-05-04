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
***Integers***
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
***Floating-Point Numbers***
* Double表示64-bit的浮點數，Float則是32-bit的浮點數
* 浮點數僅有signed
* Double精準度較高，至少有15位數，而Float最少只有6位數，所以推薦用Double

<br \>
***Type Safety and Type Inference***
* Swift是type-safe language，所以你不應該賦與一個Int給一個宣告為String的常(變)數，也因為是type-safe，在編譯階段就會去確認是否有不合理的給值，而不會在執行的階段才出現錯誤
* 有type inference就不需明確指定type
* 浮點數永遠被推斷為Double，除非你有指定Float
* 浮點數＋整數是推斷為浮點數
```swift
let anotherPi = 3 + 0.14159
// anotherPi is also inferred to be of type Double
```

<br \>
***Numeric Literals***
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
***Numeric Type Conversion***
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







