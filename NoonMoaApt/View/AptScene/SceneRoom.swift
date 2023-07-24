//
//  SceneRoom.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct SceneRoom: View {
    @ObservedObject var eyeViewController = EyeViewController()
    
    @Binding var roomUser: User
    
    @State private var isBlindUp: Bool = false
    @State var eyeGazeActive: Bool = true
    @State var lookAtPoint: CGPoint?
    @State var isWinking: Bool = false
    @State var eyeGazeAverage: CGPoint?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image.assets.room.vacant
                    .resizable()
                    .scaledToFit()
                
                Image.assets.room.dark
                    .resizable()
                    .scaledToFit()
                
                Image.assets.room.light
                    .resizable()
                    .scaledToFit()
                
                    .border(Color.red)
                if roomUser.userState == "active" {
                    
                    EyeView(isSmiling: eyeViewController.eyeModel.isSmiling,
                            isBlinkingLeft: eyeViewController.eyeModel.isBlinkingLeft,
                            isBlinkingRight: eyeViewController.eyeModel.isBlinkingRight,
                            lookAtPoint: eyeViewController.eyeModel.lookAtPoint,
                            faceOrientation: eyeViewController.eyeModel.faceOrientation)
                    .frame(width: geo.size.width * 0.75, height: geo.size.width / 1.2)
                    
                } else if roomUser.userState == "inactive" {
                    EyeInactive(roomUser: $roomUser)
                        .frame(width: geo.size.width * 0.75, height: geo.size.width / 1.2)
                }
                
                Image.assets.room.blindUp
                    .resizable()
                    .scaledToFit()
                
                Image.assets.room.blind
                    .resizable()
                    .scaledToFit()
                    .offset(y: isBlindUp ? -150 : 0)
                    .clipShape(Rectangle())
                    .onAppear {
                        if roomUser.userState == "active" || roomUser.userState == "inactive" {
                            withAnimation(.easeInOut(duration: 2)) {
                                isBlindUp = true
                            }
                        }
                    }
                
            }//ZStack
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: geo.size.width, height: geo.size.width / 1.2)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }//GeometryReader
    }
}

struct SceneRoom_Previews: PreviewProvider {
    @State static var user: User = User.sampleData[0][0]
    
    static var previews: some View {
        SceneRoom(roomUser: $user)
    }
}
