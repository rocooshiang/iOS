# Inheritance

<br \>
<br \>

## Defining a Base Class
一個Base Class的範例：
```swift
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

let someVehicle = Vehicle()

print("Vehicle: \(someVehicle.description)")
// Vehicle: traveling at 0.0 miles per hour
```

## Subclassing
* Subclass擁有superclass的所有properties和methods
* 可以額外自訂properties和methods

Subclass example，hasBasket就是subclass獨有的peoperty：
```swift
class Bicycle: Vehicle {
    var hasBasket = false
}
```

建立一個Subclass的實例，且使用自訂和superclass的property：
```swift
let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// Bicycle: traveling at 15.0 miles per hour
```

subclass也可以被其他class繼承：
```swift
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
```

subclass會繼承所有superclass的properties和methods(Tandem繼承Bicycle，Bicycle又繼承Vehicle，所以Tandem擁有Bicycle和Vehicle的properties和methods)：
```swift
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour

```

<br \>
<br \>
## Overriding

##### Accessing Superclass Methods, Properties, and Subscripts
* 訪問superclass的methods（super.someMethod()）
* 訪問superclass的properties (super.somePropertity)
* 訪問superclass的subscripts（super[someIndex]）

##### Overriding Methods

如果想變更superclass的methods內容，利用**Override**關鍵字可以覆寫superclass的methods :
```swift
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()
// Prints "Choo Choo"
```

##### Overriding Property Getters and Setters

利用super點語法來訪問superclass的methods和properties，如下方的super.description：
```swift
class Car: Vehicle {
  var gear = 1
  override var description: String {
    return super.description + " in gear \(gear)"
  }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3

print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3
```

##### Overriding Property Observers

下方例子是每次更改currentSpeed都會觸發property observers的didSet，所以間接的設定gear：
```swift
class AutomaticCar: Car {
  override var currentSpeed: Double {
    didSet {
      gear = Int(currentSpeed / 10.0) + 1
    }
  }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0

print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4
```

<br \>
<br \>
## Preventing Overrides
要防止被Override可以利用關鍵字**final**，如final var, final func, final class func,final subscript，整個class不要被繼承也可以使用final class來表達
