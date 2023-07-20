//
//  EyeInactive.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct EyeInactive: View {
    
    @Binding var roomUser: User
    @State private var userColor: Color?
    @State private var userEyeColor: Color?
    
    var body: some View {
       
        ZStack {
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
                                            .fill(userEyeColor ?? Color.eyeBlue)
                                        
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
                                            .fill(userEyeColor ?? Color.eyeBlue)
                                        
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
    }
}

struct EyeInactive_Previews: PreviewProvider {
    @State static var roomUser: User = User.sampleData[0][0]
    
    static var previews: some View {
        EyeInactive(roomUser: $roomUser)
    }
}
