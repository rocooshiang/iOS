# Type Casting

<br \>
<br \>
## Defining a Class Hierarchy for Type Casting


library的所有item會被推斷為MediaItem，因為Movie跟Song都是繼承MediaItem，可以downcast到subclass：
```swift
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
 
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// the type of "library" is inferred to be [MediaItem]
```

<br \>
<br \>
## Checking Type

**is** 用來判斷一個實例是不是包含某個subclass type，會回傳一個Bool，true代表是，false代表不是：
```swift
var movieCount = 0
var songCount = 0
 
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
 
print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"
```

<br \>
<br \>
## Downcasting
* **as?** 用在不確定是否能轉型成功的狀況下，回傳是一個Optional value
* **as!** 確定能轉型成功，如果失敗在runtime時會造成error
```swift
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}
 
// Movie: Casablanca, dir. Michael Curtiz
// Song: Blue Suede Shoes, by Elvis Presley
// Movie: Citizen Kane, dir. Orson Welles
// Song: The One And Only, by Chesney Hawkes
// Song: Never Gonna Give You Up, by Rick Astley
```


***Note: Casting並不是改變原始的type或是它的值，原始的實例保持不便***


<br \>
<br \>
## Type Casting for Any and AnyObject

* AnyObject可以代表任何class的實例
* Any可以代表任何type的實例，包含function types


***Note: 只有當你明確的需要它的行為和功能時才使用Any和AnyObject，在你的程式碼裡使用明確的型別是更好的***

<br \>
##### AnyObject

以下someObjects是一個array，允許任何class的實例(此sample只有Movie type)：
```swift
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
```

而因為someObjects只有Movie這種實例，所以我們可以直接使用**as!**將optional value做forced-unwrapping：
```swift
for object in someObjects {
    let movie = object as! Movie
    print("Movie: \(movie.name), dir. \(movie.director)")
}
// Movie: 2001: A Space Odyssey, dir. Stanley Kubrick
// Movie: Moon, dir. Duncan Jones
// Movie: Alien, dir. Ridley Scott
```

上面的loop可以有更簡潔的寫法，已經知道someObjects都是Movie了，那就直接指定[Movie]即可：
```swift
for movie in someObjects as! [Movie] {
    print("Movie: \(movie.name), dir. \(movie.director)")
}
// Movie: 2001: A Space Odyssey, dir. Stanley Kubrick
// Movie: Moon, dir. Duncan Jones
// Movie: Alien, dir. Ridley Scott
```

<br \>
##### Any

下面例子一個名為things的array，允許任何type加入，之後可以利用as(或是is)來判斷是哪種type：
```swift
var things = [Any]()
 
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as String -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
 
// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman
// Hello, Michael
```
