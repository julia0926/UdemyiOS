import UIKit


let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
button.backgroundColor = .red
//button.layer.cornerRadius = 25
//button.clipsToBounds = true

extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

button.makeCircular()



//extension Double {
//    func round(to places: Int) -> Double {
//        let precisionNumber = pow(10, Double(places)) //10^places 거듭제곱 해줌
//        var n = self
//        n = n * precisionNumber
//        n.round()
//        n = n / precisionNumber
//        return n
//    }
//}
//
//
//var myDouble = 3.14112
//
//// 위의 extenstion 이용해서 round 함수의 매개변수 입력받아 몇 제곱할건지 내부 로직 따로 커스텀
//// 함수 내용은 밑에랑 같음
////myDouble = myDouble * 1000
////myDouble.round()
////myDouble = myDouble / 1000
//
//myDouble.round(to: 1)
//
//let a = 234.2342332
