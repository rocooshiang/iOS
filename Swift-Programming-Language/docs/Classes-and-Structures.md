# Classes and Structures
<br \>
<br \>

# Comparing Classes and Structures
<br \>
相同點：
* 定義properties來儲存值
* 定義methods提供執行某些指令
* 定義subscripts來藉由subscript syntax訪問他們的值
* 定義初始值來初始狀態
* 可以被繼承來拓展額外的功能
* 遵循protocol來提供某一些功能

<br \>
Classes獨有的：
* class可以繼承另一個class
* 可以檢測一個class的類型
* Deinitializers可以釋放class任何被分配到的資源
* 允許多個常(變)數參考同一個class的實例

***Note: Structures在你使用在程式碼時總是被複製(Call by value)，且不使用reference counting***

<br \>

**Definition Syntax**
<br \>
classes與structures的定義方式：
```swift
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?  // default value is nil
}
```
***Note: Classes與structures命名原則都是大寫開頭，properties與methods則是用小寫開頭***

<br \>

**Class and Structure Instances**
<br \>
class和structure實體化：
```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

<br \>

**Accessing Properties**
<br \>
取值和賦與值：
```swift
someResolution.width  // 0
someVideoMode.resolution.width  // 0
someVideoMode.resolution.width = 1280  // assign value
```

<br \>

**Memberwise Initializers for Structure Types**
<br\>
只有structure有預設的成員constructor：
```swift
let vga = Resolution(width: 640, height: 480)
```

<br \>
<br \>
# Structures and Enumerations Are Value Types
<br \>
* Value Types意思就是Call by value，不管是assign到一個常數或變數，又或者是傳入一個function，都是將其複製一份
* Structures、Enumerations、integers、floating-point numbers、Booleans、strings、arrays and dictionaries都是Value Types

以下例子證明Structures是call by value，儘管將hd的width改變，但是也不影響cinema的width：
```swift
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"

print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"
```

同理，Enumerations也是call by value，兩個物件也不會互相影響：
```swift
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}
// Prints "The remembered direction is still .West"
```

<br \>
<br \>
# Classes Are Reference Types
<br \>
* Reference Types意思是call by reference，不管是assign到一個常數或變數，又或者是傳入一個function，都是參考同一個地方

以下例子證明Classes是call by reference，兩個物件的屬性會互相影響：
```swift
let tenEighty = VideoMode()
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"
```

<br \>

**Identity Operators**
<br \>
Classes是Reference Types，所以有可能很多常(變數)其實是指向同一個實例，為了辨別這樣的狀況，Swift提供簡單的運算子來檢驗
* 相同(===) 
* 不同(!==)

```swift
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."
```

* "Identical to"(===)是同樣的reference
* "Equal to"(==)是同樣的值
 
<br \>

# Choosing Between Classes and Structures
<br \>
***Note: 如何去選擇要使用classes和structures呢？兩者最大的分別就是一個是reference types，另一個是value types***

<br \>

以下條件可以考慮使用structures：
* 封裝幾個相對簡單的data
* 當你是需要複製封裝的值，而不是參考同樣的值
* 任何儲存在structures的屬性type都是被複製的
* 不需要繼承其他class

<br \>

適用於structures的狀況：
* 將幾何圖形的width和height儲存到structures進行封裝，其type為Double
* 一個層級的range，將他的屬性start和length儲存到structures進行封裝，其type為Int
* 3D座標系x,y,z儲存到structures進行封裝，其type為Double


<br \>

# Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
<br \>
* 在Swift基礎的data如String、Array和Dictionary都是實作structures，意思就是他們都是value types
* Foundation的NSString, NSArray, and NSDictionary是實作classes，也就是說是reference types

