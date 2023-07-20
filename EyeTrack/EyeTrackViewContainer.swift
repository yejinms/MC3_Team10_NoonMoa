//
//  EyeTrackViewContainer.swift
//  MC3
//
//  Created by 최민규 on 2023/07/19.
//

import SwiftUI
import ARKit
import RealityKit

struct CustomARViewContainer: UIViewRepresentable {
    
    @Binding var eyeGazeActive: Bool
    @Binding var lookAtPoint: CGPoint?
    @Binding var isWinking: Bool
    @Binding var eyeGazeAverage: CGPoint?

    func makeUIView(context: Context) -> CustomARView {
        return CustomARView(eyeGazeActive: $eyeGazeActive, lookAtPoint: $lookAtPoint, isWinking: $isWinking, eyeGazeAverage: $eyeGazeAverage)
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}


class CustomARView: ARView, ARSessionDelegate {

    let eyeTrack = EyeTrackViewModel()
    
    @Binding var eyeGazeActive: Bool
    @Binding var lookAtPoint: CGPoint?
    @Binding var isWinking: Bool
    @Binding var eyeGazeAverage: CGPoint?


    init(eyeGazeActive: Binding<Bool>, lookAtPoint: Binding<CGPoint?>, isWinking: Binding<Bool>, eyeGazeAverage: Binding<CGPoint?>) {
        _eyeGazeActive = eyeGazeActive
        _lookAtPoint = lookAtPoint
        _isWinking = isWinking
        _eyeGazeAverage = eyeGazeAverage

        super.init(frame: .zero)

        self.cameraMode = .ar

        self.debugOptions = [.none]

        self.session.delegate = self

        let configuration = ARFaceTrackingConfiguration()
        self.session.run(configuration)
    }


    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {

        guard eyeGazeActive, let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }

        /// 1. Locate Gaze point
        detectGazePoint(faceAnchor: faceAnchor)
        // eyeGazeActive.toggle()

        /// 2. Detect winks
        detectWink(faceAnchor: faceAnchor)

    }


    private func detectGazePoint(faceAnchor: ARFaceAnchor){
          
        guard let eyeLookOutRight = faceAnchor.blendShapes[.eyeLookOutRight] as? Float,
              let eyeLookInRight = faceAnchor.blendShapes[.eyeLookInRight] as? Float,
              let eyeLookUpRight = faceAnchor.blendShapes[.eyeLookUpRight] as? Float,
              let eyeLookDownRight = faceAnchor.blendShapes[.eyeLookDownRight] as? Float else {
            return
        }

        let eyeX = eyeLookInRight - eyeLookOutRight
        let eyeY = eyeLookDownRight - eyeLookUpRight
        
        let focusPoint = CGPoint(

            x: 150 + CGFloat(eyeX * 100),
            y: 200 + CGFloat(eyeY * 100)
            
        )

//        let lookAtPointInWorld = faceAnchor.transform * simd_float4(lookAtPoint, 1)
//
//        let transformedLookAtPoint = simd_mul(simd_inverse(cameraTransform), lookAtPointInWorld)
//
//        let screenX = transformedLookAtPoint.y / (Float(Device.screenSize.width)) * Float(Device.frameSize.width)
//        let screenY = transformedLookAtPoint.x / (Float(Device.screenSize.height)) * Float(Device.frameSize.height)
//
//        let focusPoint = CGPoint(
//
//            x: CGFloat(screenX).clamped(to: Ranges.widthRange),
//            y: CGFloat(screenY).clamped(to: Ranges.heightRange)
//        )

        DispatchQueue.main.async {
//            self.lookAtPoint = focusPoint
//            print("\(eyeX), \(eyeY)")
            
            self.eyeTrack.eyeGazeHistory.append(focusPoint)
            let suffixHistory: Array<CGPoint> = self.eyeTrack.eyeGazeHistory.suffix(self.eyeTrack.numberOfUpdates)
            self.eyeGazeAverage = suffixHistory.averagePoint
            self.lookAtPoint = self.eyeGazeAverage
        }
    }

    
    private func detectWink(faceAnchor: ARFaceAnchor) {

        let blendShapes = faceAnchor.blendShapes

        if let leftEyeBlink = blendShapes[.eyeBlinkLeft] as? Float,
           let rightEyeBlink = blendShapes[.eyeBlinkRight] as? Float {
            if leftEyeBlink > 0.9 && rightEyeBlink > 0.9 {
                isWinking = true
                print("Blink")

            } else {
                isWinking = false
            }
        }
    }

//    //가장높은 값을 그 방향이라고 인식하고자하는데 지금 매우 이상
//    private func detectEyeDirection(faceAnchor: ARFaceAnchor) {
//        let blendShapes = faceAnchor.blendShapes
//
//        if let eyeLookLeft = blendShapes[.eyeLookOutLeft] as? Float {
//            print("Left: \(eyeLookLeft)")
//        }
//
//        if let eyeLookRight = blendShapes[.eyeLookInLeft] as? Float {
//            print("Right: \(eyeLookRight)")
//        }
//
//        if let eyeLookUp = blendShapes[.eyeLookUpLeft] as? Float {
//            print("Up: \(eyeLookUp)")
//        }
//
//        if let eyeLookDown = blendShapes[.eyeLookDownLeft] as? Float {
//            print("Down: \(eyeLookDown)")
//        }
////
////        DispatchQueue.main.async {
////            self.eyeDirection = maxEyeDirection
////        }
//    }
//
//    private func detectEyebrowRaise(faceAnchor: ARFaceAnchor){
//
//        let browInnerUp = faceAnchor.blendShapes[.browInnerUp] as? Float ?? 0.0
//
//        let eyebrowRaiseThreshold: Float = 0.1
//
//        let isEyebrowRaised = browInnerUp > eyebrowRaiseThreshold
//
//        if isEyebrowRaised {
//            isWinking = true
//            print("Eyebrow Raised")
//        }else{
//            isWinking = false
//
//        }
//    }

    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}
