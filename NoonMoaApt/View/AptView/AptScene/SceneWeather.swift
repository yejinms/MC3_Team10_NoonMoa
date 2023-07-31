//
//  SceneWeather.swift
//  MC3
//
//  Created by 최민규 on 2023/07/15.
//

import SwiftUI
import Lottie

struct SceneWeather: View {
    @EnvironmentObject var aptViewModel: AptViewModel
    
    var body: some View {
        
        switch weather.currentWeather {
        case WeatherViewModel.clear:
            if time.isDayTime {
                LottieView(name: Lottie.clearDay, animationSpeed: 1)
                    .ignoresSafeArea()
                
            } else {
                LottieView(name: Lottie.clearNight, animationSpeed: 1)
                    .ignoresSafeArea()
            }
        case WeatherViewModel.cloudy:
            if time.isDayTime {
                LottieView(name: Lottie.cloudyDay, animationSpeed: 1)
                    .ignoresSafeArea()
            } else {
                LottieView(name: Lottie.cloudyNight, animationSpeed: 1)
                    .ignoresSafeArea()
            }
        case WeatherViewModel.rainy:
            if time.isDayTime {
                LottieView(name: Lottie.rainyDay, animationSpeed: 1)
                    .ignoresSafeArea()
            } else {
                LottieView(name: Lottie.rainyNight, animationSpeed: 1)
                    .ignoresSafeArea()
            }
        case WeatherViewModel.snowy:
            if time.isDayTime {
                LottieView(name: Lottie.snowyDay, animationSpeed: 1)
                    .ignoresSafeArea()
            } else {
                LottieView(name: Lottie.snowyNight, animationSpeed: 1)
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
