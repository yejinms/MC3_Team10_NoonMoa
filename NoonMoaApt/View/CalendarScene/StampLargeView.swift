//
//  StampLargeView.swift
//  MC3
//
//  Created by Seohyun Hwang on 2023/07/20.
//

import SwiftUI

struct StampLargeView: View {
    
    var skyColor: LinearGradient
    var skyImage: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(skyColor)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6)
            .overlay {
                Image(skyImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                // MARK: - 해당 날의 캐릭커 출석 모습 넣기
                RoundedRectangle(cornerRadius: 40)
                    .strokeBorder(Color.black, lineWidth: 2)
                Image("Eye_stamp")
                    .resizable()
                    .scaledToFit()
            }
    }
}

struct StampLDesign: View {
    
    @StateObject var weather: WeatherViewModel = WeatherViewModel()
    @StateObject var time: TimeViewModel = TimeViewModel()
    
    
    var body: some View {
        switch weather.currentWeather {
        case WeatherViewModel.clear:
            if time.isDayTime {     // 맑은 낮
                StampLargeView(skyColor: Color.sky.clearDay, skyImage: "LargeStamp_clearDay")
            } else {                // 맑은 밤
                StampLargeView(skyColor: Color.sky.clearNight, skyImage: "LargeStamp_clearDay")                }
        case WeatherViewModel.cloudy:
            if time.isDayTime {     // 흐린 낮
                StampLargeView(skyColor: Color.sky.cloudyDay, skyImage: "LargeStamp_cloudyDay")
            } else {                // 흐린 밤
                StampLargeView(skyColor: Color.sky.cloudyNight, skyImage: "LargeStamp_cloudyDay")
            }
        case WeatherViewModel.rainy:
            if time.isDayTime { // 비 오는 낮
                StampLargeView(skyColor: Color.sky.rainyDay, skyImage: "LargeStamp_rainyDay")
            } else {            // 비 오는 밤
                StampLargeView(skyColor: Color.sky.rainyNight, skyImage: "LargeStamp_rainyDay")
            }
        case WeatherViewModel.snowy:
            if time.isDayTime { // 눈 오는 낮
                StampLargeView(skyColor: Color.sky.snowyDay, skyImage: "LargeStamp_snowyDay")
            } else {            // 눈 오는 밤
                StampLargeView(skyColor: Color.sky.snowyNight, skyImage: "LargeStamp_snowyDay")
            }
        case WeatherViewModel.thunder:
            if time.isDayTime { // 번개 낮
                StampLargeView(skyColor: Color.sky.cloudyDay, skyImage: "LargeStamp_thunder")
            } else {            // 번개 밤
                StampLargeView(skyColor: Color.sky.cloudyNight, skyImage: "LargeStamp_thunder")
            }
        default:
            EmptyView()
        }
    }
}

struct StampLargeView_Previews: PreviewProvider {
    static var previews: some View {
        StampLargeView(skyColor: Color.sky.clearDay, skyImage: "LargeStamp_clearDay")
    }
}
