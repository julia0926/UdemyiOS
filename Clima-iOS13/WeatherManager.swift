//
//  WeatherManager.swift
//  Clima
//
//  Created by 김지인 on 2021/11/02.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate { //여기서 delegate 선언 
    func didUpdateWeater(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWIthError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=66559e90c50074a9fea2dcce0f48ae06&units=metric"
    
    var delegate: WeatherManagerDelegate? //프로토콜을 선언해서 외부 ViewController의 함수 사용
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            //3. Give the sesstion a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWIthError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {//self 키워드를 사용해서 같은 영역안에서 사용됨을 나타내야 됨
                        delegate?.didUpdateWeater(self, weather: weather) //Manager, 프로토콜
                    }
                    
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? { //optional
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
             
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch{
            delegate?.didFailWIthError(error: error)
            return nil //에러날 때 리턴할 게 없으므로
        }
    }
    
    
}
