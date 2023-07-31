//
//  EnvironmentModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import Foundation
import SwiftUI

class EnvironmentModel: ObservableObject {
    
    var rawWeather: String
    var rawTime: Date
    var rawtSunriseTime: Date
    var rawSunsetTime: Date
    
    @Published var currentWeather: String
    @Published var currentIsWind: Bool
    @Published var currentIsThunder: Bool
    @Published var currentTime: String
    @Published var currentLottieImageName: String
    @Published var currentColorOfSky: LinearGradient
    @Published var currentColorOfGround: LinearGradient
    @Published var currentBroadcastText: String
    @Published var currentStampLargeSkyImageName: String
    @Published var currentStampSmallSkyImageName: String
    @Published var currentStampBorderColor: Color
    
    var recordedRawWeather: String
    var recordedRawSunriseTime: Date
    var recordedRawSunsetTime: Date
    var recordedRawTime: Date
    
    var recordedWeather: String
    var recordedIsWind: Bool
    var recordedIsThunder: Bool
    var recordedTime: String
    
    var recordedLottieImageName: String
    var recordedColorOfSky: LinearGradient
    var recordedColorOfGround: LinearGradient
    var recordedBroadcastText: String
    var recordedStampLargeSkyImageName: String
    var recordedStampSmallSkyImageName: String
    var recordedStampBorderColor: Color
    
    //앱을 시작할 때 실행시키며, 10분단위로 실행시킨다. 이 모델을 따르는 뷰는 자동으로 업데이트 된다.
    func getCurrentEnvironment() {
        getCurrentRawEnvironment()
        convertRawDataToEnvironment(isInputCurrentData: true, weather: rawWeather, time: rawTime, sunrise: rawtSunriseTime, sunset: rawSunsetTime)
        convertEnvironmentToViewData(isInputCurrentData: true, weather: currentWeather, time: currentTime, isThunder: currentIsThunder)
    }
    
    func getCurrentRawEnvironment() {
        //        rawWeather = 웨더킷에서 현재 날씨값 String 받아오기
        //        rawSunriseTime = 웨더킷에서 받아오기
        //        rawSunsetTime = 웨더킷에서 받아오기
        //        rawTime = 현재 시간}
    }
    
    func saveRawEnvironment()  {
        //attendanceModel.newAttendanceRecord(...)
    }
    
    //앱을 시작할 때 실행시키고, 달력을 켰을 때 접근한다.
    func fetchRecordedEnvironment(record: AttendanceRecord)  {
        saveRecordedRawEnvironmentToEnvironmentModel(record: record)
        convertRawDataToEnvironment(isInputCurrentData: false, weather: recordedRawWeather, time: recordedRawTime, sunrise: recordedRawSunriseTime, sunset: recordedRawSunsetTime)
        convertEnvironmentToViewData(isInputCurrentData: false, weather: recordedWeather, time: recordedTime, isThunder: recordedIsThunder)
    }
    
    func saveRecordedRawEnvironmentToEnvironmentModel(record: AttendanceRecord) {
        recordedRawWeather = record.rawWeather
        recordedRawSunriseTime = record.rawtSunriseTime
        recordedRawSunsetTime = record.rawSunsetTime
        recordedRawTime = record.rawTime
    }
    
    
    func convertRawDataToEnvironment(isInputCurrentData: Bool, weather: String, time: Date, sunrise: Date, sunset: Date) {
        
        let environmentWeather: String
        switch weather {
        case "1", "2", "3": environmentWeather = "clear"
        case "4", "5", "6", "7": environmentWeather = "cloudy"
        case "8", "9", "10": environmentWeather = "rainy"
        case "11", "12", "13": environmentWeather = "snowy"
        default: environmentWeather = ""
        }
        
        let environmentIsWind: Bool
        switch weather {
        case "1", "2", "3": environmentIsWind = true
        case "4", "5", "6", "7": environmentIsWind = false
        case "8", "9", "10": environmentIsWind = false
        case "11", "12", "13": environmentIsWind = false
        default: environmentIsWind = false
        }
        
        let environmentIsThunder: Bool
        switch weather {
        case "1", "2", "3": environmentIsThunder = false
        case "4", "5", "6", "7": environmentIsThunder = true
        case "8", "9", "10": environmentIsThunder = false
        case "11", "12", "13": environmentIsThunder = true
        default: environmentIsThunder = false
        }
        
        let environmentTime: String
        let t = getHourFromDate(time: time)
        let sunrise = getHourFromDate(time: sunrise)
        let sunset = getHourFromDate(time: sunset)
        switch t {
        case let t where t == sunrise: environmentTime = "sunrise"
        case let t where t == sunset: environmentTime = "sunset"
        case let t where (t >= 22) || (t >= 0 && t < 6): environmentTime = "night"
        case let t where t >= 6 && t < 12: environmentTime = "morning"
        case let t where t >= 12 && t < 18: environmentTime = "afternoon"
        case let t where t >= 18 && t < 22: environmentTime = "evening"
        default: environmentTime = ""
        }
        if isInputCurrentData {
            currentWeather = environmentWeather
            currentIsWind = environmentIsWind
            currentIsThunder = environmentIsThunder
            currentTime = environmentTime
        } else {
            recordedWeather = environmentWeather
            recordedIsWind = environmentIsWind
            recordedIsThunder = environmentIsThunder
            recordedTime = environmentTime
        }
    }
    
    func getHourFromDate(time: Date) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        return hour
    }
    func convertEnvironmentToViewData(isInputCurrentData: Bool, weather: String, time: String, isThunder: Bool) {
        var viewData = [String: Any]()
        switch weather {
        case "clear":
            switch time {
            case "sunrise":
                viewData = ["lottieImageName": Lottie.clearSunrise,
                            "colorOfSky": LinearGradient.sky.clearSunrise,
                            "colorOfGround": LinearGradient.ground.clearSunrise,
                            "broadcastText": Text.broadcast.clearSunrise,
                            "stampLargeSkyImageName": Image.assets.stampLarge.clearSunrise,
                            "stampSmallSkyImageName": Image.assets.stampSmall.clearSunrise,
                            "stampBorderColor": Color.stampBorder.clearSunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.clearMorning,
                            "colorOfSky": LinearGradient.sky.clearMorning,
                            "colorOfGround": LinearGradient.ground.clearMorning,
                            "broadcastText": Text.broadcast.clearMorning,
                            "stampLargeSkyImageName": Image.assets.stampLarge.clearMorning,
                            "stampSmallSkyImageName": Image.assets.stampSmall.clearMorning,
                            "stampBorderColor": Color.stampBorder.clearMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.clearAfternoon,
                            "colorOfSky": LinearGradient.sky.clearAfternoon,
                            "colorOfGround": LinearGradient.ground.clearAfternoon,
                            "broadcastText": Text.broadcast.clearAfternoon,
                            "stampLargeSkyImageName": Image.assets.stampLarge.clearAfternoon,
                            "stampSmallSkyImageName": Image.assets.stampSmall.clearAfternoon,
                            "stampBorderColor": Color.stampBorder.clearAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.clearSunset,
                            "colorOfSky": LinearGradient.sky.clearSunset,
                            "colorOfGround": LinearGradient.ground.clearSunset,
                            "broadcastText": Text.broadcast.clearSunset,
                            "stampLargeSkyImageName": Image.assets.stampLarge.clearSunset,
                            "stampSmallSkyImageName": Image.assets.stampSmall.clearSunset,
                            "stampBorderColor": Color.stampBorder.clearSunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.clearEvening,
                            "colorOfSky": LinearGradient.sky.clearEvening,
                            "colorOfGround": LinearGradient.ground.clearEvening,
                            "broadcastText": Text.broadcast.clearEvening,
                            "stampLargeSkyImageName": Image.assets.stampLarge.clearEvening,
                            "stampSmallSkyImageName": Image.assets.stampSmall.clearEvening,
                            "stampBorderColor": Color.stampBorder.clearEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.clearNight,
                            "colorOfSky": LinearGradient.sky.clearNight,
                            "colorOfGround": LinearGradient.ground.clearNight,
                            "broadcastText": Text.broadcast.clearNight,
                            "stampLargeSkyImageName": Image.assets.stampLarge.clearNight,
                            "stampSmallSkyImageName": Image.assets.stampSmall.clearNight,
                            "stampBorderColor": Color.stampBorder.clearNight]
            }
            
        }
        
        if isInputCurrentData {
            currentLottieImageName = viewData["lottieImageName"] as! String
            currentColorOfSky = viewData["colorOfSky"] as! LinearGradient
            currentColorOfGround = viewData["colorOfGround"] as! LinearGradient
            currentBroadcastText = viewData["broadcastText"] as! String
            
            currentStampLargeSkyImageName = viewData["stampLargeSkyImageName"] as! String
            currentStampSmallSkyImageName = viewData["stampSmallSkyImageName"] as! String
            currentStampBorderColor = viewData["stampBorderColor"] as! Color
        } else {
            recordedLottieImageName = viewData["recordedLottieImageName"] as! String
            recordedColorOfSky = viewData["recordedColorOfSky"] as! LinearGradient
            recordedColorOfGround = viewData["recordedColorOfGround"] as! LinearGradient
            recordedBroadcastText = viewData["recordedBroadcastText"] as! String
            
            recordedStampLargeSkyImageName = viewData["recordedStampLargeSkyImageName"] as! String
            recordedStampSmallSkyImageName = viewData["recordedStampSmallSkyImageName"] as! String
            recordedStampBorderColor = viewData["recordedStampBorderColor"] as! Color
        }
    }
}

