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
//    var isSmiling: Bool
//    var isBlinkingLeft: Bool
//    var isBlinkingRight: Bool
//    var lookAtPoint: SIMD3<Float>
//    var faceOrientation: SIMD3<Float>
//    var bodyColor: Color
//    var eyeColor: Color
    
    var scale: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(skyColor)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            .overlay {
                Image(skyImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                // MARK: - 해당 날의 캐릭커 출석 모습 넣기
                Image("Eye_stamp")
                    .resizable()
                    .scaledToFit()
                RoundedRectangle(cornerRadius: 50)
                    .strokeBorder(Color.black, lineWidth: 2)
            }//overlay
            .scaleEffect(scale)
    }
}


struct StampLargeView_Previews: PreviewProvider {
    static var previews: some View {
        StampLargeView(skyColor: Color.sky.clearDay, skyImage: "LargeStamp_clearDay", scale: 0.85)
    }
}

struct StampLDesign: View {
    
    @StateObject var weather: WeatherViewModel = WeatherViewModel()
    @StateObject var time: TimeViewModel = TimeViewModel()
    var isAttendanceView: Bool
    var isStamped: Bool
    
    var body: some View {
        // (1) AttendanceView에 나타나는 Stamp일 경우
        if isAttendanceView == true && isStamped == false {
            StampLargeView(skyColor: Color.sky.unStampedWhite, skyImage: "", scale: 0.85)
        }
        // (2) AttendanceCompletedView에 나타나는 Stamp일 경우
        if isAttendanceView == true && isStamped == true {
            
            switch weather.currentWeather {
                // 맑은 날
            case WeatherViewModel.clear:
                StampLargeView(skyColor: time.isDayTime ? Color.sky.clearDay : Color.sky.clearNight, skyImage: "LargeStamp_clearDay", scale: 0.85)
                
                // 흐린 날
            case WeatherViewModel.cloudy:
                StampLargeView(skyColor: time.isDayTime ? Color.sky.cloudyDay : Color.sky.cloudyNight, skyImage: "LargeStamp_cloudyDay", scale: 0.85)
                
                // 비오는 날
            case WeatherViewModel.rainy:
                    StampLargeView(skyColor: time.isDayTime ? Color.sky.rainyDay : Color.sky.rainyNight, skyImage: "LargeStamp_rainyDay", scale: 0.85)
                
                // 눈 오는 날
            case WeatherViewModel.snowy:
                    StampLargeView(skyColor: time.isDayTime ? Color.sky.snowyDay : Color.sky.snowyNight, skyImage: "LargeStamp_snowyDay", scale: 0.85)
                
                // 번개 치는 날
            case WeatherViewModel.thunder:
                    StampLargeView(skyColor: time.isDayTime ? Color.sky.cloudyDay : Color.sky.cloudyNight, skyImage: "LargeStamp_thunder", scale: 0.85)
            default:
                EmptyView()
            }
        }
        
        // (3) CalendarDayView에 나타나는 Stamp일 경우
        if isAttendanceView == false && isStamped == true {
            
        }
    }
}


struct StampLDesign_Previews: PreviewProvider {
    static var previews: some View {
        StampLDesign(isAttendanceView: true, isStamped: true)
    }
}
