//
//  Weather.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

//TODO: TimeViewModel을 여기에 통합시키는게 나을까?
class WeatherViewModel: ObservableObject {
    @Published var currentWeatherRaw: String = "clear123"
    @Published var currentWeather: String = "clear"
    @Published var savedSkyColor: LinearGradient = Color.sky.clearDay
    @Published var savedSkyImage: Image = Image.assets.weather.clearDay
}

extension WeatherViewModel {
    static let clear: String = "clear"
    static let cloudy: String = "cloudy"
    static let rainy: String = "rainy"
    static let snowy: String = "snowy"
    static let thunder: String = "thunder"
}

extension WeatherViewModel {
    func getCurrentWeather() {
        //TODO: 웨더킷으로부터 현재 날씨 받아와서 currentWeatherRaw에 넣을 것
        switch self.currentWeatherRaw {
        case "clear123":
            currentWeather = "clear"
        default : break
        }
    }
    
    func getColorFromCurrentWeather() {
    //TODO: db에서 string으로 날씨 받아서 self.currentWeather에 부여할 것
        
        switch self.currentWeather {
        case "clear":
            savedSkyColor = Color.sky.clearDay
            savedSkyImage = Image.assets.largeStamp.clearDay
        case "cloudy":
            savedSkyColor = Color.sky.cloudyDay
            savedSkyImage = Image.assets.largeStamp.cloudyDay
        case "rainy":
            savedSkyColor = Color.sky.rainyDay
            savedSkyImage = Image.assets.largeStamp.rainyDay
        case "snowy":
            savedSkyColor = Color.sky.snowyDay
            savedSkyImage = Image.assets.largeStamp.snowyDay
        case "thunder":
            savedSkyColor = Color.sky.cloudyDay
            savedSkyImage = Image.assets.largeStamp.thunder
        default : break
        }
    }
}
