import UIKit

class Animal {
    var name: String
    init(n: String){
        name = n
    }
}

class Human: Animal {
    func code() {
        print("Tying away...")
    }
}

class Fish: Animal {
    func breatheUnderWater(){
        print("Breathing under water.")
    }
}

//struct Fish: Animal {
//    func breatheUnderWater(){
//        print("Breathing under water.")
//    }
//}

let julia = Human(n: "Julia Kim")
let jack = Human(n: "Jack Park")
let nemo = Fish(n: "Nemo")

let neighbours = [julia,jack,nemo] //각각 다른 데이터 타입이지만, 부모 클래스가 Animal이기 때문에 Array는 슈퍼클래스인 Animal임.

//let neighbour1 = neighbours[0] //Animal

if neighbours[2] is Human { //is 키워드는 해당 데이터 타입이 맞는지 확인시 Typing checking
    print("Human!")
}

func findNemo(from animals: [Animal]){
    for animal in animals {
        if animal is Fish{
            print(animal.name)
            let fish = animal as! Fish //타입을 Fish로 다운 캐스팅 함 . Force downcasting
            fish.breatheUnderWater()
            let animalFish = fish as? Animal //UpCasting

        }
    }
}


findNemo(from: neighbours)

if let fish = neighbours[1] as? Fish {
    fish.breatheUnderWater()
} else {
    "Casting has failed "
}

let fish = neighbours[1] as? Fish
fish?.name


//error ! Human to Fish로 캐스팅 할 수 없다 !
