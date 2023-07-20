//
//  SceneRoom.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct SceneRoom: View {
    @State private var isBlindUp: Bool = false
    @State var roomUser: Int = 0
    
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
                
                //나중에 움직이는 눈으로 교체
                EyeActive()
                
                EyeInactive()
                    .opacity(0)
                
                Image.assets.room.blindUp
                    .resizable()
                    .scaledToFit()
                
                Image.assets.room.blind
                    .resizable()
                    .scaledToFit()
                    .offset(y: isBlindUp ? -150 : 0)
                    .clipShape(Rectangle())
                    .onAppear {
                        if roomUser % 2 == 0 {
                            withAnimation(.easeInOut(duration: 2)) {
                                isBlindUp = true
                            }
                        }
                    }
                
                InfoLastActive()
                    .opacity(0)
                
                InfoLastWakenTime()
                    .opacity(0)
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
    static var previews: some View {
        SceneRoom()
    }
}
