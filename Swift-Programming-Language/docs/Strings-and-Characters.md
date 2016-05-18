Strings and Characters
----------

Counting Characters
----------
* extended grapheme clusters for Character 意思是不一定會影響到string的長度
* 同一個字元可能是不同的Extended grapheme clusters組成的，也就是說佔的記憶體也不一致
* NSString長度是基於UTF-16的數量，不是Unicode extended grapheme clusters的數量
```swift
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// Prints "the number of characters in cafe is 4"
 
word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
 
print("the number of characters in \(word) is \(word.characters.count)")
// Prints "the number of characters in café is 4"
```

<br \>
Accessing and Modifying a String
----------
***String Indices***
<br \>
注意以下例子greeting有10個字元，index由0開始，但是結束的index卻是10(應該是讓inser比較好寫吧？)：
```swift
var greeting = "Guten Tag!"

greeting.startIndex
// 0
greeting.endIndex
// 10
greeting[greeting.startIndex]
// G
greeting[greeting.endIndex.predecessor()]
// !
greeting[greeting.startIndex.successor()]
// u

let index = greeting.startIndex.advancedBy(7)
greeting[index]
// 
```

找倒數第幾個字元，注意倒數過來第一個有效index是-1：
```swift
let index = greeting.endIndex.advancedBy(-1)
greeting[index]
// a
```

***Inserting and Removing***
<br \>
insert:
```swift
var welcome = "hello"
welcome.insert("!", atIndex: welcome.endIndex)
// welcome now equals "hello!"

welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())
// welcome now equals "hello there!"
```

remove:
```swift
welcome.removeAtIndex(welcome.endIndex.predecessor())
// welcome now equals "hello there"

let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)
// welcome now equals "hello"
```

Comparing Strings
----------
相同的語言意義與外觀，就算是不同Unicode組成的，也視為相等：
```swift
// "café?"
let eAcuteQuestion = "caf\u{E9}?"

// "café?"
let combinedEAcuteQuestion = "caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
  print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"


let latinCapitalLetterA: Character = "\u{41}"  // used in English
 
let cyrillicCapitalLetterA: Character = "\u{0410}"  // used in Russian
 
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}
// Prints "These two characters are not equivalent"

```

***Prefix and Suffix Equality***
<br \>
確認字首或字尾有沒有包含某些字元：
```swift
let name = "Rocoo Chao"

if name.hasPrefix("Ro"){
  print("Prefix true")
}
// Prefix true

if name.hasSuffix("o"){
  print("Suffix true")
}
// Suffix true
```


