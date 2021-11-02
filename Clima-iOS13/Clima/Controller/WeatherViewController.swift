//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self //이렇게 함으로써 밑에 func 들 사용 가능
        // 즉,UITextFieldDelegate에 들어있는 함수를 재정의해서 사용 가능
    }

    @IBAction func searchPresed(_ sender: UIButton) { //써치 아이콘 누를 때
        searchTextField.endEditing(true) //검색하면 키보드가 저절로 사라짐
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //키보드의 return 누를 때 함수
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { //텍스트 검증 위한 함수
        if textField.text != "" {
            return true
        } else { //비어있게 된다면  placeholder 넣음
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { //검색을 다 하고 실행되는 메소드 (빈 문자열로 변경)
        if let city = searchTextField.text{ //text 데이터 타입이 옵셔널이므로 옵셔널로 감쌈
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
    }
    
}

