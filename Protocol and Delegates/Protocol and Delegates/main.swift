
protocol AdvancedLifeSupport{
    func performCPR()
}

class EmergnecyCallHandler{
    var delegate: AdvancedLifeSupport? //프로토콜을 데이터 타입으로
    
    func assessSituation(){
        print("무슨 일이 일어났는지 알려줄 수 있나요?")
    }
    func medicalEmergency(){
        delegate?.performCPR() //handler로 연결되어 있는 누구든 아무나 CPR 해달라
    }
}

struct Paramedic: AdvancedLifeSupport { // 프로토콜을 사용했으니 반드시 performCPR 메소드 재선언해야됨!
    
    init(handler: EmergnecyCallHandler){
        handler.delegate = self
    }
    
    func performCPR() {
        print("paramedic이 30초 동안 심폐소생술")
    }
    
    
}

class Doctor: AdvancedLifeSupport{
    
    init(handler: EmergnecyCallHandler){
        handler.delegate = self
    }
    
    func performCPR() {
        print("의사가 30초 동안 심폐소생술")
    }
    
    func useStethescrope(){
        print("심장 박동수 확인 ")
    }
}

class Surgeon: Doctor { //Default로 AdvancedLifeSupport 됨, Doctor를 상속했으므로
    override func performCPR() {
        super.performCPR() //Doctor의 메소드도 사용하면서
        print("Sing?!@?@")
        
    }
    func useElectricDrill() {
        print("Whirr....")
    }
}

let emilio = EmergnecyCallHandler()
let pete = Doctor(handler: emilio) //emilio가 호출기 울릴 때 대기(듣고이씀)

emilio.assessSituation()
emilio.medicalEmergency()

//1. delegate?.performCPR()이 실행되면서
//2. handler로 받은 클래스의 performCPR() 실행됨.
// 즉, pete의 handler에 emilior인 클래스가 Doctor이므로 Doctor.performCPR() 실행된다.
