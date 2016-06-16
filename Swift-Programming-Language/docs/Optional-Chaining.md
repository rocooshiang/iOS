# Optional Chaining

<br \>
<br \>

## Optional Chaining as an Alternative to Forced Unwrapping

下面code展示如何使用Optional Chaining：
```swift
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."


john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."
```

<br \>
<br \>
## Defining Model Classes for Optional Chaining

利用幾個class來展示optional chaining定義model：
```swift
class Person {
  var residence: Residence?
}

class Residence {
  var rooms = [Room]()
  
  var numberOfRooms: Int {
    return rooms.count
  }
  
  subscript(i: Int) -> Room {
    get {
      return rooms[i]
    }
    set {
      rooms[i] = newValue
    }
  }
  
  func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
  }
  
  var address: Address?
  
}

class Room {
  let name: String
  init(name: String) { self.name = name }
}


class Address {
  var buildingName: String?
  var buildingNumber: String?
  var street: String?
  
  func buildingIdentifier() -> String? {
    if buildingName != nil {
      return buildingName
    } else if buildingNumber != nil && street != nil {
      return "\(buildingNumber) \(street)"
    } else {
      return nil
    }
  }
}
```

<br \>
<br \>
## Accessing Properties Through Optional Chaining


因為john.residence?是nil，所以fail：
```swift
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress  // Set value fail
```

下面程式碼說明，optional chaining如果是nil，那之後的程式碼都不會執行，所以下方不會用prints：
```swift
func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
john.residence?.address = createAddress()
```

<br \>
<br \>
## Calling Methods Through Optional Chaining

以下示範，經由一個optional chaining呼叫，那會回傳optional type，下方是回傳Void?：
```swift
func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
}

if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// Prints "It was not possible to print the number of rooms."
```

<br \>
<br \>
## Accessing Subscripts Through Optional Chaining

示範經由optional chaining使用subscripts，以下皆是失敗，因為john.residence?是nil：
```swift
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "Unable to retrieve the first room name."

john.residence?[0] = Room(name: "Bathroom")
```

Assign john.residence一個非nil的值，就能成功使用subscripts：
```swift
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse
 
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "The first room name is Living Room."
```

<br \>
##### Accessing Subscripts of Optional Type

```swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
```

<br \>
<br \>
## Linking Multiple Levels of Chaining

以下是兩層的optional chaining，因為john.residence?.address?是nil，所以fail：
```swift
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."

Assign john.residence?.address一個非nil值，以下取得street就能成功：
```swift
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress
 
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "John's street name is Laurel Street."
```

<br \>
<br \>
## Chaining on Methods with Optional Return Values

如之前定義的，buildingIdentifier這個方法是回傳一個String?，所以會回傳一個optional chaining：
```swift
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Prints "John's building identifier is The Larches."
```
