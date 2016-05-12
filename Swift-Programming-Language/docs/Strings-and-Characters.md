Strings and Characters
----------

**Counting Characters**
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


