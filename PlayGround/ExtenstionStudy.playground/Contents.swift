import UIKit

extension Double {
    func round(to places: Int) -> Double {
        let precisionNumber = pow(10, Double(places)) //10^places 거듭제곱 해줌
        var n = self
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}


var myDouble = 3.14112

// 위의 extenstion 이용해서 round 함수의 매개변수 입력받아 몇 제곱할건지 내부 로직 따로 커스텀
// 함수 내용은 밑에랑 같음
//myDouble = myDouble * 1000
//myDouble.round()
//myDouble = myDouble / 1000

myDouble.round(to: 1)

let a = 234.2342332
a.round()
