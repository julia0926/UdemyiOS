//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager() //지역 정보를 얻기위해 사용
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self //먼저 선언해야 됨 
        locationManager.requestWhenInUseAuthorization() //현재 위치 앱에 인증 여부 물어봄
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self //이렇게 함으로써 밑에 func 들 사용 가능
        // 즉,UITextFieldDelegate에 들어있는 함수를 재정의해서 사용 가능
    }

}
//MARK: - CLLocationManager
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude //위도
            let lon = location.coordinate.longitude //경도
            weatherManager.fetchWeather(latitude: lat, longitute: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - UITextFieldDelgate
//섹션을 나눠줌

extension WeatherViewController: UITextFieldDelegate {
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

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeater(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async { //비동기식
            self.temperatureLabel.text = weather.temperatureString //model의 온도 문자열로 변경된 값
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
       
    }
    func didFailWIthError(error: Error) {
        print(error)
    }
}
