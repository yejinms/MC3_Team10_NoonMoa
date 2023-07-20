//
//  FunctionTestView.swift
//  MC3
//
//  Created by 최민규 on 2023/07/17.
//

import SwiftUI

struct FunctionTestView: View {
    @EnvironmentObject var weather: WeatherViewModel
    @EnvironmentObject var time: TimeViewModel

    @State private var index: Int = 0
    var body: some View {
            VStack {
                HStack(spacing: 8) {
                    Button(action: {
                        time.isDayTime.toggle()
                    }) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .frame(width: 96, height: 48)
                            .overlay(
                                Text("Day/Night")
                                    .foregroundColor(.black)
                                    .font(.body)
                            )
                            .opacity(0.2)
                    }
                    Button(action: {
                        let array = ["clear", "cloudy", "rainy", "snowy"]
                        index = (index + 5) % 4
                        weather.currentWeather = array[index]
                    }) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .frame(width: 96, height: 48)
                            .overlay(
                                Text("Weather\nShuffle")
                                    .foregroundColor(.black)
                                    .font(.body)
                            )
                            .opacity(0.2)
                    }
                 Spacer()
                }
                .padding()
                Spacer()
            }
    }
}

struct FunctionTestView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionTestView()
            .environmentObject(WeatherViewModel())
            .environmentObject(TimeViewModel())
    }
}
