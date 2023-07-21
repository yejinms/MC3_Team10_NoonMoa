//
//  StampButton.swift
//  MC3
//
//  Created by Seohyun Hwang on 2023/07/20.
//

import SwiftUI

struct StampButtons: View {
    
    @StateObject var weather: WeatherViewModel = WeatherViewModel()
    @StateObject var time: TimeViewModel = TimeViewModel()
    // MARK: - 해당 날의 캐릭커 출석 모습 넣기
    var userImage: String = "Eye_stamp" // 임시방편으로 이미지 에셋 넣어둠. 그 날의 출석사진(?)으로 대체 필요.
    
    var body: some View {
        
        switch weather.currentWeather {
            case WeatherViewModel.clear:
                if time.isDayTime {     // 맑은 낮
                    StampDesign(borderColor: Color.stampBorder.clearDay, skyColor: Color.sky.clearDay, skyImage: "Stamp_clearDay", userImage: userImage)
                } else {                // 맑은 밤
                    StampDesign(borderColor: Color.stampBorder.clearNight, skyColor: Color.sky.clearNight, skyImage: "Stamp_clearNight", userImage: userImage)
                }
            case WeatherViewModel.cloudy:
                if time.isDayTime {     // 흐린 낮
                    StampDesign(borderColor: Color.stampBorder.cloudyDay, skyColor: Color.sky.cloudyDay, skyImage: "Stamp_cloudyDay", userImage: userImage)
                } else {                // 흐린 밤
                    StampDesign(borderColor: Color.stampBorder.cloudyNight, skyColor: Color.sky.cloudyNight, skyImage: "Stamp_cloudyNight", userImage: userImage)
                }
            case WeatherViewModel.rainy:
                    if time.isDayTime { // 비 오는 낮
                        StampDesign(borderColor: Color.stampBorder.cloudyDay, skyColor: Color.sky.rainyDay, skyImage: "Stamp_rainyDay", userImage: userImage)
                    } else {            // 비 오는 밤
                        StampDesign(borderColor: Color.stampBorder.cloudyDay, skyColor: Color.sky.rainyNight, skyImage: "Stamp_rainyNight", userImage: userImage)
                    }
            case WeatherViewModel.snowy:
                    if time.isDayTime { // 눈 오는 낮
                        StampDesign(borderColor: Color.stampBorder.snowyDay, skyColor: Color.sky.snowyDay, skyImage: "Stamp_snowy", userImage: userImage)
                    } else {            // 눈 오는 밤
                        StampDesign(borderColor: Color.stampBorder.snowyNight, skyColor: Color.sky.snowyNight, skyImage: "Stamp_snowy", userImage: userImage)
                    }
            case WeatherViewModel.thunder:
                    if time.isDayTime { // 번개 낮
                        StampDesign(borderColor: Color.stampBorder.cloudyDay, skyColor: Color.sky.cloudyDay, skyImage: "Stamp_thunder", userImage: userImage)
                    } else {            // 번개 밤
                        StampDesign(borderColor: Color.stampBorder.cloudyDay, skyColor: Color.sky.cloudyNight, skyImage: "Stamp_thunder", userImage: userImage)
                    }
            default:
                 EmptyView()
        }
    }
}

struct StampDesign: View {

    let borderColor: Color
    let skyColor: LinearGradient
    let skyImage: String
    let userImage: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(skyColor)
            Image(skyImage)
                .resizable()
                .scaledToFit()
            Image(userImage)
                .resizable()
                .scaledToFit()
            Circle()
                .strokeBorder(borderColor)
        }
    }
}

struct StampButtons_Previews: PreviewProvider {
    static var previews: some View {
        StampButtons()
    }
}
