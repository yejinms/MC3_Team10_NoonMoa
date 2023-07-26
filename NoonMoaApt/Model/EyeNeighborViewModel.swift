//
//  EyeNeighborViewModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/26.
//
import SwiftUI

//TODO: 아직 서버에서는 상대방의 움직임을 받아오는게 없으므로, 초기화 값을 지정해 주었다. 나중에는 이 뷰모델에, 서버에서 받은 값을 각 값에 뿌려주는 func를 작성한다.
//TODO: 제발...
struct EyeNeighborViewModel {
    var isSmiling: Bool = false
    var isBlinkingLeft: Bool = false
    var isBlinkingRight: Bool = false
    var lookAtPoint: SIMD3 = SIMD3<Float>(0.0, 0.0, 0.0)
    var faceOrientation: SIMD3 = SIMD3<Float>(0.0, 0.0, 0.0)
    var bodyColor: Color = .userBlue
    var eyeColor: Color = .eyeBlue
    
    mutating func update(roomUser: User) {
        switch roomUser.eyeColor {
        case "eyeBlue" :
            bodyColor = .userBlue
            eyeColor = .eyeBlue
        case "eyeCyan" :
            bodyColor = .userCyan
            eyeColor = .eyeCyan
        case "eyePink" :
            bodyColor = .userPink
            eyeColor = .eyePink
        case "eyeYellow" :
            bodyColor = .userYellow
            eyeColor = .eyeYellow
        default:
            break
        }
    }
}
