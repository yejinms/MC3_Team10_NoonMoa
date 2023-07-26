//
//  EyeNeighborView.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/25.
//

import SwiftUI

struct SceneNeighborEye: View {
    @Binding var roomUser: User
    @State private var eyeNeighborModel = EyeNeighborViewModel()
    
    var body: some View {
        EyeView(isSmiling: eyeNeighborModel.isSmiling,
                isBlinkingLeft: eyeNeighborModel.isBlinkingLeft,
                isBlinkingRight: eyeNeighborModel.isBlinkingRight,
                lookAtPoint: eyeNeighborModel.lookAtPoint,
                faceOrientation: eyeNeighborModel.faceOrientation,
                bodyColor: eyeNeighborModel.bodyColor,
                eyeColor: eyeNeighborModel.eyeColor)
        .onAppear {
            eyeNeighborModel.update(roomUser: roomUser)
        }
    }
}

struct SceneNeighborEye_Previews: PreviewProvider {
    static var previews: some View {
        SceneNeighborEye(roomUser: .constant(User.sampleData[0][1]))
    }
}
