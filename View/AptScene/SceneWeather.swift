//
//  SceneWeather.swift
//  MC3
//
//  Created by 최민규 on 2023/07/15.
//

import SwiftUI

struct SceneWeather: View {
    @EnvironmentObject var weather: WeatherViewModel
    @EnvironmentObject var time: TimeViewModel
    
    var body: some View {
        
        switch weather.currentWeather {
        case WeatherViewModel.clear:
            if time.isDayTime {
                Image.assets.weather.clearDay
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image.assets.weather.clearNight
                    .resizable()
                    .ignoresSafeArea()
            }
        case WeatherViewModel.cloudy:
            if time.isDayTime {
                Image.assets.weather.cloudyDay
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image.assets.weather.cloudyNight
                    .resizable()
                    .ignoresSafeArea()
            }
        case WeatherViewModel.rainy:
            if time.isDayTime {
                Image.assets.weather.rainyDay
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image.assets.weather.rainyNight
                    .resizable()
                    .ignoresSafeArea()
            }
        case WeatherViewModel.snowy:
            if time.isDayTime {
                Image.assets.weather.snowyDay
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Image.assets.weather.snowyNight
                    .resizable()
                    .ignoresSafeArea()
            }
        default: EmptyView()
        }
        
    }
}

struct SceneWeather_Previews: PreviewProvider {
    static var previews: some View {
        SceneWeather()
            .environmentObject(WeatherViewModel())
            .environmentObject(TimeViewModel())
    }
}
