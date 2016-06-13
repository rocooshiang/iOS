# Deinitialization

* 只適用於Class
* 使用關鍵字**deinit**定義deinitializer
* 在一個class的實例釋放之後立即的呼叫deinitializer

<br \>
<br \>
## How Deinitialization Works
Swift仰賴ARC的機制去釋放你長久沒有使用的instances，一般情況下，當你的instances釋放掉，你不用手動去清除，
但是某些狀況下，你就必須自己動手去清除，舉個例子，當你自定一個class去打開一個檔案，並且去寫了一些數據，
這時候當instance釋放時，你得手動關閉這個檔案

一個class最多只能擁有一個deinitializer，不帶任何參數，也沒有小括號：
```swift
deinit {
    // perform the deinitialization
}
```

<br \>
* 你沒有權限呼叫deinitializer，系統會自動呼叫
* Superclass deinitializer被subclass繼承，當subclass執行deinitializer結束，會呼叫superclass的deinitializer
* Superclass deinitializer永遠會被呼叫，即使subclass沒有自定deinitializer

<br \>
<br \>
## Deinitializers in Action

下面是一個使用deinitializers的例子，關鍵在於playerOne = nil，deinitializers自動被呼叫了，所以所有硬幣都回到Bank了：
```swift
class Bank {
    static var coinsInBank = 10_000
    
    static func vendCoins(numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"

print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"

playerOne!.winCoins(2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Prints "PlayerOne won 2000 coins & now has 2100 coins"

print("The bank now only has \(Bank.coinsInBank) coins left")
// Prints "The bank now only has 7900 coins left"

playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"

print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"
```
