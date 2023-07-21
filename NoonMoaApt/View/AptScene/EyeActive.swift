//
//  EyeTrackView.swift
//  MC3
//
//  Created by 최민규 on 2023/07/19.
//

import SwiftUI
import ARKit
import RealityKit

struct EyeActive: View {
    @EnvironmentObject var eyeTrack: EyeTrackViewModel
    let viewModel = ARViewContainer.ViewModel()
    
    @Binding var eyeGazeActive: Bool
    @Binding var lookAtPoint: CGPoint?
    @Binding var isWinking: Bool
    @Binding var eyeGazeAverage: CGPoint?
    
    @Binding var roomUser: User
    @State private var userColor: Color?
    @State private var userEyeColor: Color?
    
    var body: some View {
        ZStack {
            //            CustomARViewContainer(eyeGazeActive: $eyeGazeActive, lookAtPoint: $lookAtPoint, isWinking: $isWinking, eyeGazeAverage: $eyeGazeAverage)
            GeometryReader { geo in
                Ellipse()
                    .fill(userColor ?? Color.userBlue)
                    .overlay(
                        Ellipse()
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(width: geo.size.width, height: geo.size.width * 0.85)
                    .overlay(
                        HStack(spacing: 2) {
                            Ellipse()
                                .fill(Color.white)
                                .frame(width: geo.size.width * 0.25, height: geo.size.width * 0.25 * 1.8)
                                .overlay(
                                    ZStack {
                                        Ellipse()
                                            .fill(Color.black)
                                            .offset(x: lookAtPoint?.x ?? 0, y: lookAtPoint?.y ?? 0)
                                            .opacity(isWinking ? 0 : 1)
                                            .frame(width: geo.size.width * 0.25 * 0.5, height: geo.size.width * 0.25 * 1.5 * 0.45)
                                        
                                        Ellipse()
                                            .fill(userEyeColor ?? Color.eyeBlue)
                                            .opacity(isWinking ? 1 : 0)
                                        
                                        Ellipse()
                                            .stroke(Color.black, lineWidth: 1)
                                    }
                                )
                            
                            Ellipse()
                                .fill(Color.white)
                                .frame(width: geo.size.width * 0.25, height: geo.size.width * 0.25 * 1.8)
                                .overlay(
                                    ZStack {
                                        Ellipse()
                                            .fill(Color.black)
                                            .offset(x: lookAtPoint?.x ?? 0, y: lookAtPoint?.y ?? 0)
                                            .opacity(isWinking ? 0 : 1)
                                            .frame(width: geo.size.width * 0.25 * 0.5, height: geo.size.width * 0.25 * 1.5 * 0.45)
                                        
                                        Ellipse()
                                            .fill(userEyeColor ?? Color.eyeBlue)
                                            .opacity(isWinking ? 1 : 0)
                                        
                                        Ellipse()
                                            .stroke(Color.black, lineWidth: 1)
                                    }
                                )
                        }//HStack
                    )
                    .onAppear {
                        switch roomUser.eyeColor {
                        case "eyeBlue" :
                            userColor = Color.userBlue
                            userEyeColor = Color.eyeBlue
                        case "eyeCyan" :
                            userColor = Color.userCyan
                            userEyeColor = Color.eyeCyan
                        case "eyePink" :
                            userColor = Color.userPink
                            userEyeColor = Color.eyePink
                        case "eyeYellow" :
                            userColor = Color.userYellow
                            userEyeColor = Color.eyeYellow
                        default :
                            userColor = Color.userBlue
                            userEyeColor = Color.eyeBlue
                        }
                    }
            }//GeometryReader
        }//ZStack
        
        
        //지우지말것!!!
        //        ZStack(alignment: .bottom) {
        //            CustomARViewContainer(eyeGazeActive: $eyeGazeActive, lookAtPoint: $lookAtPoint, isWinking: $isWinking, eyeGazeAverage: $eyeGazeAverage)
        ////            Button(action: {
        ////                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
        ////                    eyeGazeActive.toggle()
        ////                }
        ////            }, label: {
        ////                Text(eyeGazeActive ? "Stop" : "Start")
        ////                    .font(.headline)
        ////                    .foregroundColor(.white)
        ////                    .padding()
        ////                    .background(Color.blue)
        ////                    .cornerRadius(10)
        ////            })
        ////            .padding(.bottom, 50)
        //
        //                GeometryReader { geo in
        //                    ZStack {
        //                        Ellipse()
        //                            .fill(Color.userBlue)
        //                            .overlay(
        //                                Ellipse()
        //                                    .stroke(Color.black, lineWidth: 1)
        //                            )
        //                            .frame(width: geo.size.width, height: geo.size.width * 0.85)
        //
        //                        HStack(spacing: 8) {
        //                            Ellipse()
        //                                .fill(Color.white)
        //                                .frame(width: geo.size.width * 0.25, height: geo.size.width * 0.25 * 1.5)
        //                                .overlay(
        //                                    ZStack {
        //                                        Ellipse()
        //                                            .fill(Color.black)
        //                                            .offset(x: lookAtPoint?.x ?? 0, y: lookAtPoint?.y ?? 0)
        //                                            .opacity(isWinking ? 0 : 1)
        //                                            .frame(width: geo.size.width * 0.25 * 0.5, height: geo.size.width * 0.25 * 1.5 * 0.45)
        //
        //                                        Ellipse()
        //                                            .fill(Color.eyeBlue)
        //                                            .opacity(isWinking ? 1 : 0)
        //
        //                                        Ellipse()
        //                                            .stroke(Color.black, lineWidth: 1)
        //                                    }
        //                                )
        //
        //                            Ellipse()
        //                                .fill(Color.white)
        //                                .frame(width: geo.size.width * 0.25, height: geo.size.width * 0.25 * 1.5)
        //                                .overlay(
        //                                    ZStack {
        //                                        Ellipse()
        //                                            .fill(Color.black)
        //                                            .offset(x: lookAtPoint?.x ?? 0, y: lookAtPoint?.y ?? 0)
        //                                            .opacity(isWinking ? 0 : 1)
        //                                            .frame(width: geo.size.width * 0.25 * 0.5, height: geo.size.width * 0.25 * 1.5 * 0.45)
        //
        //                                        Ellipse()
        //                                            .fill(Color.eyeBlue)
        //                                            .opacity(isWinking ? 1 : 0)
        //
        //                                        Ellipse()
        //                                            .stroke(Color.black, lineWidth: 1)
        //                                    }
        //                                )
        //                        }//HStack
        //                    }//ZStack
        //                }
        //            }
    }
}



struct EyeActive_Previews: PreviewProvider {
    @State static var eyeGazeActive = true
    @State static var lookAtPoint: CGPoint? = CGPoint(x: 0, y: 0)
    @State static var isWinking = false
    @State static var eyeGazeAverage: CGPoint? = CGPoint(x: 100, y: 100)
    @State static var roomUser: User = User.sampleData[0][0]
    
    static var previews: some View {
        EyeActive(eyeGazeActive: $eyeGazeActive, lookAtPoint: $lookAtPoint, isWinking: $isWinking, eyeGazeAverage: $eyeGazeAverage, roomUser: $roomUser)
            .environmentObject(EyeTrackViewModel())
    }
}
