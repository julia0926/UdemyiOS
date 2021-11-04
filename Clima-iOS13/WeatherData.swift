//
//  WeatherData.swift
//  Clima
//
//  Created by 김지인 on 2021/11/04.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable { //Decoderable + Encoderable = Codable
    let name: String
    let main: Main
    let weather: [Weather] //Array일 때 이렇게 표현
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
