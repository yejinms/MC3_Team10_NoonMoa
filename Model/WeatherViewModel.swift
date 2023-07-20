//
//  Weather.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: String = "clear"
    
}

extension WeatherViewModel {
    static let clear: String = "clear"
    static let cloudy: String = "cloudy"
    static let rainy: String = "rainy"
    static let snowy: String = "snowy"

}

