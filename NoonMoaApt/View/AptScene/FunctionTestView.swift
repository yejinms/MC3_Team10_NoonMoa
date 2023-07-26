//
//  FunctionTestView.swift
//  MC3
//
//  Created by 최민규 on 2023/07/17.
//

import SwiftUI

struct FunctionTestView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @EnvironmentObject var weather: WeatherViewModel
    @EnvironmentObject var time: TimeViewModel
    
    @State private var index: Int = 0
    @Binding var buttonText: String
    
    var body: some View { 
        VStack(alignment: .leading) {
            Spacer().frame(height: 48)
            HStack(spacing: 8) {
                Button(action: {
                    time.isDayTime.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Day/Night")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
                Button(action: {
                    let array = ["clear", "cloudy", "rainy", "snowy"]
                    index = (index + 5) % 4
                    weather.currentWeather = array[index]
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Weather\nShuffle")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(width: 80, height: 48)
                    .overlay(
                        Text(buttonText)
                            .foregroundColor(.black)
                            .font(.caption)
                    )
                    .opacity(0.1)
                Button(action: {
                    EyeViewController().resetFaceAnchor()
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Reset\nFace")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 8) {
                Button(action: {
                    viewRouter.currentView = .attendance
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Attendance\nView")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
                Button(action: {
                    //random
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Random\nShuffle")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct FunctionTestView_Previews: PreviewProvider {
    @State static var buttonText: String = ""
    
    static var previews: some View {
        FunctionTestView(buttonText: $buttonText)
            .environmentObject(WeatherViewModel())
            .environmentObject(TimeViewModel())
    }
}
