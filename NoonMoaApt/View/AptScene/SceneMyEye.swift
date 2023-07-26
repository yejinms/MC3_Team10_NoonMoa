//
//  EyeMyView.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/25.
//

import SwiftUI

struct SceneMyEye: View {
    @EnvironmentObject var eyeViewController: EyeViewController

    var body: some View {
        
        EyeView(isSmiling: eyeViewController.eyeMyModel.isSmiling,
                isBlinkingLeft: eyeViewController.eyeMyModel.isBlinkingLeft,
                isBlinkingRight: eyeViewController.eyeMyModel.isBlinkingRight,
                lookAtPoint: eyeViewController.eyeMyModel.lookAtPoint,
                faceOrientation: eyeViewController.eyeMyModel.faceOrientation,
                bodyColor: eyeViewController.eyeMyModel.bodyColor,
                eyeColor: eyeViewController.eyeMyModel.eyeColor)
    }
}



struct SceneMyEye_Previews: PreviewProvider {
    static var previews: some View {
        SceneMyEye()
    }
}
