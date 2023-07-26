//
//  EyeInactive.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct SceneInactiveEye: View {
    
    @Binding var roomUser: User
    @State private var eyeNeighborModel = EyeNeighborViewModel()
    
    var body: some View {
       
        EyeView(isSmiling: false,
                isBlinkingLeft: true,
                isBlinkingRight: true,
                lookAtPoint: SIMD3<Float>(0.0, 0.0, 0.0),
                faceOrientation: SIMD3<Float>(0.0, 0.0, 0.0),
                bodyColor: eyeNeighborModel.bodyColor,
                eyeColor: eyeNeighborModel.eyeColor)
        .onAppear {
            eyeNeighborModel.update(roomUser: roomUser)
        }
    }
}

struct SceneInactiveEye_Previews: PreviewProvider {
    @State static var roomUser: User = User.sampleData[0][0]
    
    static var previews: some View {
        SceneInactiveEye(roomUser: $roomUser)
    }
}
