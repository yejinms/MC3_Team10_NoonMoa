//
//  SceneRoom.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct SceneRoom: View {
    @Binding var roomUser: User

    @State private var isBlindUp: Bool = false
    @State var eyeGazeActive: Bool = true
    @State var lookAtPoint: CGPoint?
    @State var isWinking: Bool = false
    @State var eyeGazeAverage: CGPoint?
    
    var body: some View {
        
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
            
            if roomUser.userState == "active" {
                //나중에 움직이는 눈으로 교체
                EyeActive(eyeGazeActive: $eyeGazeActive, lookAtPoint: $lookAtPoint, isWinking: $isWinking, eyeGazeAverage: $eyeGazeAverage, roomUser: $roomUser)
                    .frame(width: 80, height: 70)
            } else if roomUser.userState == "inactive" {
                EyeInactive(roomUser: $roomUser)
                    .frame(width: 80, height: 70)
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
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 2)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }
}

struct SceneRoom_Previews: PreviewProvider {
    @State static var user: User = User.sampleData[0][0]
    
    static var previews: some View {
        SceneRoom(roomUser: $user)
    }
}
