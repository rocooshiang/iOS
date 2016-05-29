# Closures
<br \>

Global 和 Nested functions都是屬於特殊的closures：
* Global functions有名稱，但是沒辦法捕獲任何值
* Nested functions有名稱且能從其封閉的function捕獲值 
* Closure expressions是沒有名稱的，使用輕量化的寫法，並且利用前後關係來捕獲值


closure expressions的優化：
* 從前後關係來推斷參數及回傳type
* 單一表達式closures的回傳
* 速記參數名稱
* 尾隨閉包語法
