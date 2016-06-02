# Properties
<br \>
<br \>

# Stored Properties
<br \>
**Stored Properties of Constant Structure Instances**
<br \>
<br \>
因為rangeOfFourItems是constant，就算firstValue是設定為變數，但還是不能被改變：
```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3

rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property
```

但是呢，在class就不會有以上問題：
```swift
class FixedLengthRange {
  var firstValue: Int = 0
  var length: Int = 0
  
  init(firstValue: Int,length: Int){
    self.firstValue = firstValue
    self.length = length
  }
}

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3

rangeOfFourItems.firstValue = 6
// this range represents integer values 6, 7, 8, and 9
```
***Note: 因為Class是Reference types，即使實例是定義為constant，但是還是能更改定義為variable的屬性***

<br \>
<br \>
**Lazy Stored Properties**
* 第一次被使用時，lazy properties才會賦與初始值
* 使用關鍵字**lazy**來表示要定義一個屬性為lazy properties
* Lazy properties一定要是個variable的property，因為constant在初始化完成之前就一定會有值了
* Lazy properties經常使用在一個property需要很複雜的計算才能得到它的值，或是這個值是藉由外來因素而產生的，所以只需要在這個值有被用到時在去assign value就好了

以下例子大概描述lazy的使用時機(不完整的code)，完成code之後，importer還是沒有被建立，因為它根本沒有使用到：
```swift
class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}
 
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}
 
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property has not yet been created
```

接續之前的動作，以下manager.importer.fileName很明顯的已經第一次使用到importer，這時候就會被建立起來：
```swift
print(manager.importer.fileName)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"
```
***Note: 如果一個Lazy property被很多thread同時訪問，那將不保證該property只初始化一次***

<br \>
<br \>
# Computed Properties
<br \>
除了直接給properties預設值以外，還能接受由外部提供的某些數據，然後經過自訂的一些計算後再賦與值：
```swift    
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"
```

<br \>
<br \>
**Shorthand Setter Declaration**
<br \>
Swift提供一個default name，使用newValue就表示新參數名稱：
```swift
set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
    }
```

<br \>
<br \>
# Property Observers
* 當property的值有被設定時就會響應，即時設定的新值與舊值的一樣
* Observers可以設定在任何儲存的屬性，但是lazy stored properties不行
* 可以新增observers在一個繼承父類別的子類裡
* willSet 在Value儲存前被呼叫，可以自訂新值名稱，或是使用newValue這個預設名稱
* didSet 在新值被儲存時立即呼叫，如上，didSet也能自訂新值名稱或是使用預設名稱oldValue

以下例子willSet使用自訂參數名稱，didSet使用預設名稱：
```swift
class StepCounter {
  var totalSteps: Int = 0 {
    willSet (newTotalSteps){
      print("About to set totalSteps to \(newTotalSteps)")
    }
    didSet {
      if totalSteps > oldValue  {
        print("Added \(totalSteps - oldValue) steps")
      }
    }
  }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
```

<br \>
<br \>
# Global and Local Variables
<br \>
Global的常(變)數都是lazy stored properties，不需額外加上lazy關鍵字

<br \>
<br \>
# Type Properties
<br \>
**Type Property Syntax**
<br \>
使用關鍵字static定義一個type property，如果是class，那可以使用關鍵字class來取代static表明可以被繼承的class override：
```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
```

<br \>
<br \>
**Querying and Setting Type Properties**
<br \>
Type properties是不用利用初始化該type的物件，就能直接取得與賦與值了：
```swift

print(SomeStructure.storedTypeProperty)
// Prints "Some value."

SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."

print(SomeEnumeration.computedTypeProperty)
// Prints "6"

print(SomeClass.computedTypeProperty)
// Prints "27"
```

以下音量example展示使用type properties的好處：
```swift
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Prints "7"

print(AudioChannel.maxInputLevelForAllChannels)
// Prints "7"

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// Prints "10"

print(AudioChannel.maxInputLevelForAllChannels)
// Prints "10"
```
***Note: 以上example簡單來說有點像是電影院的售票口，雖然售票口有兩個，但是一場電影院的電影票是固定的，利用type properties來設定總票數，不管是哪個窗口賣出去的都會從這個property減掉賣出去的量，那就能控管總票數剩餘幾張***

