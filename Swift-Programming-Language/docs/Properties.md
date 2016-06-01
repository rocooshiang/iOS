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




