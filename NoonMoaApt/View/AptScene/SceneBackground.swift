//
//  SceneBackground.swift
//  MC3
//
//  Created by 최민규 on 2023/07/15.
//

import SwiftUI

struct SceneBackground: View {
    @EnvironmentObject var weather: WeatherViewModel
    @EnvironmentObject var time: TimeViewModel
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                switch weather.currentWeather {
                case WeatherViewModel.clear:
                    if time.isDayTime {
                        Color.sky.clearDay
                        GroundView(colorOfGround: Color.ground.grassGreen, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                        
                    } else {
                        Color.sky.clearNight
                        GroundView(colorOfGround: Color.ground.grassGreen, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                    }
                case WeatherViewModel.cloudy:
                    if time.isDayTime {
                        Color.sky.cloudyDay
                        GroundView(colorOfGround: Color.ground.dirtBrown, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                    } else {
                        Color.sky.cloudyNight
                        GroundView(colorOfGround: Color.ground.dirtBrown, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                    }
                case WeatherViewModel.rainy:
                    if time.isDayTime {
                        Color.sky.rainyDay
                        GroundView(colorOfGround: Color.ground.dirtBrown, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                    } else {
                        Color.sky.rainyNight
                        GroundView(colorOfGround: Color.ground.dirtBrown, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                    }
                case WeatherViewModel.snowy:
                    if time.isDayTime {
                        Color.sky.snowyDay
                        GroundView(colorOfGround: Color.ground.snowWhite, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                    } else {
                        Color.sky.snowyNight
                        GroundView(colorOfGround: Color.ground.snowWhite, geoSizeWidth: geo.size.width)
                            .offset(y: geo.size.height / 2)
                    }
                default: EmptyView()
                }
            }
            .ignoresSafeArea()
        }
    }
}

//사다리꼴
struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Top edge
        path.move(to: CGPoint(x: rect.minX + insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        
        // Right slanted edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // Bottom edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Left slanted edge
        path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: rect.minY))
        
        return path
    }
}

struct GroundView: View {
    
    var colorOfGround: LinearGradient = Color.ground.grassGreen
    var geoSizeWidth: Double = 0.0
    
    var body: some View {
        Rectangle()
            .fill(colorOfGround)
            .frame(height: geoSizeWidth / 4)
            .overlay(
                Trapezoid(insetAmount: geoSizeWidth * 0.15)
                    .fill(Color.ground.pathBeige)
                    .overlay(
                        Trapezoid(insetAmount: geoSizeWidth * 0.15)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(width: geoSizeWidth * 0.55)
            )
            .overlay(
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 1)
                    .offset(y: -geoSizeWidth / 8)
            )
    }
}

struct SceneBackground_Previews: PreviewProvider {
    
    static var previews: some View {
        SceneBackground()
            .environmentObject(WeatherViewModel())
            .environmentObject(TimeViewModel())
        
    }
}
