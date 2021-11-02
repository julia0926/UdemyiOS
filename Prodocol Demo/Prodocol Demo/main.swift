//
//  main.swift
//  Prodocol Demo
//
//  Created by 김지인 on 2021/11/02.
//

protocol CanFly {
    func fly() //프로토콜은 body를 갖지 않는다. {}를 추가하면 error
    //사용하는 클래스에서 재정의 해야 됨
}

class Bird {
    
    var isFemale = true
    
    func layEgg(){
        if isFemale {
            print("알을 낳아용")
        }
    }
    
    
}

class Eagle: Bird, CanFly {
    func fly() {
        print("하늘을 날고 날개를 펼쳐~")
    }
    //Bird를 상속하는 Eagle 클래스 , CanFly 프로토콜을 사용
    
    func soar(){
        print("하늘을 가로질러 날라가~~")
    }
}

class Penguin: Bird {
    func swim() {
        print("물에서 첨벙첨벙 ")
    }
}

struct FlyingMuseum {
    func flyingDemo(flyingObject: CanFly) { //데이터 타입으로 프로토콜
        flyingObject.fly()
    }
}

//--------Struct는 상속하지 않음, Class만 상속 가능

struct Airplane: CanFly{ //상속하지 않고도 프로토콜만 사용해서 필요한 함수 정의
    func fly() {
        print("비행기는 엔진으로 날고 착륙하지")
    }
    
    
}

let myEagle = Eagle()
let myPenguin = Penguin()
let myPlane = Airplane()

myPenguin.layEgg()
myPenguin.swim()
//myPenguin.fly() //펭귄은 날 수 없음


myEagle.fly()

let museum = FlyingMuseum()
// museum.flyingDemo(flyingObject: myPenguin) 펭귄은 CanFly 프로토콜 갖고있지 않음
museum.flyingDemo(flyingObject: myPlane)
