//
//  EyeTrackViewModel.swift
//  MC3
//
//  Created by 최민규 on 2023/07/19.
//

import SwiftUI
import ARKit
import RealityKit
import SceneKit

class EyeTrackViewModel: ObservableObject {
    @Published var eyeGazeHistory: Array<CGPoint> = []
    @Published var numberOfUpdates = 15
}

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
        
        self.cameraMode = .nonAR
        
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
              let eyeLookDownRight = faceAnchor.blendShapes[.eyeLookDownRight] as? Float,
              let eyeLookOutLeft = faceAnchor.blendShapes[.eyeLookOutLeft] as? Float,
              let eyeLookInLeft = faceAnchor.blendShapes[.eyeLookInLeft] as? Float,
              let eyeLookUpLeft = faceAnchor.blendShapes[.eyeLookUpLeft] as? Float,
              let eyeLookDownLeft = faceAnchor.blendShapes[.eyeLookDownLeft] as? Float
        else {
            return
        }
        
        //LookOutRight은 왼쪽이 1.0 가운데가 0.0 오른쪽이 0.0
        //LookInRight은  왼쪽이 0.0 가운데가 0.0 오른쪽이 1.0
        //LookOutLeft는 왼쪽이 0.0 가운데가 0.0 오른쪽이 1.0
        //LookInLeft는  왼쪽이 1.0 가운데가 0.0 오른쪽이 0.0
        //위는 눈 기준이고, 얼굴을 돌리는 개념이면 반대가 될 수 있다.
        
        let eyeX = min(eyeLookOutRight, eyeLookInLeft) - min(eyeLookInRight, eyeLookOutLeft)
        let eyeY = min(eyeLookUpRight, eyeLookUpLeft) - min(eyeLookDownRight, eyeLookDownLeft)
        
        // 범위 설정
        let minX: CGFloat = -15 // Minimum x value
        let maxX: CGFloat = 15  // Maximum x value
        let minY: CGFloat = -35 // Minimum y value
        let maxY: CGFloat = 35  // Maximum y value
        
        // 민감도 설정
        let xValue = CGFloat(eyeX * 100)
        let yValue = CGFloat(eyeY * 300)
        
        // 최종 값 설정
        let boundedX = min(max(xValue, minX), maxX)
        let boundedY = min(max(yValue, minY), maxY)
        
        let focusPoint = CGPoint(x: boundedX, y: boundedY)
        
        DispatchQueue.main.async {
            print("\(xValue), \(yValue)")
            self.eyeTrack.eyeGazeHistory.append(focusPoint)
            if self.eyeTrack.eyeGazeHistory.count > 25 {
                self.eyeTrack.eyeGazeHistory.removeFirst(self.eyeTrack.eyeGazeHistory.count - 25)
            }
            let suffixHistory: Array<CGPoint> = self.eyeTrack.eyeGazeHistory.suffix(self.eyeTrack.numberOfUpdates)
            self.eyeGazeAverage = suffixHistory.averagePoint
            self.lookAtPoint = self.eyeGazeAverage
            print( self.eyeTrack.eyeGazeHistory.count)
        }
    }
    
    
    private func detectWink(faceAnchor: ARFaceAnchor) {
        
        let blendShapes = faceAnchor.blendShapes
        
        if let leftEyeBlink = blendShapes[.eyeBlinkLeft] as? Float,
           let rightEyeBlink = blendShapes[.eyeBlinkRight] as? Float {
            if leftEyeBlink > 0.9 && rightEyeBlink > 0.9 {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isWinking = true
                }
            } else {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isWinking = false
                }
            }
        }
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    struct ViewModel {
        var trackingState: ARCamera.TrackingState? = nil
    }
    
    @Binding var viewModel: ViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        // Create the view.
        let arView = ARView(frame: .zero)
        
        if ARFaceTrackingConfiguration.isSupported {
            let configuration = ARFaceTrackingConfiguration()
            configuration.isWorldTrackingEnabled = true // Enable front-facing camera
            
            arView.session.run(configuration)
        }
        
        // Set the coordinator as the session delegate
        arView.session.delegate = context.coordinator
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, ARSessionDelegate {
        
        var parent: ARViewContainer
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
            parent.viewModel.trackingState = camera.trackingState
        }
    }
}

extension CGFloat {
    func clamped(to: ClosedRange<CGFloat>) -> CGFloat {
        return to.lowerBound > self ? to.lowerBound
            : to.upperBound < self ? to.upperBound
            : self
    }
}

extension Array where Element == CGPoint {
    var averagePoint: CGPoint {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        for item in self {
            x += item.x
            y += item.y
        }
        
        let elementCount = CGFloat(self.count)
        return CGPoint(x: CGFloat(x / elementCount), y: CGFloat(y / elementCount))
    }
}


////
////  EyeTrackViewModel.swift
////  MC3
////
////  Created by 최민규 on 2023/07/19.
////
//
//import SwiftUI
//import ARKit
//import RealityKit
//import SceneKit
//
//class EyeTrackViewModel: ObservableObject {
//    @Published var eyeGazeHistory: Array<CGPoint> = []
//    @Published var numberOfUpdates = 25
//    @Published var eyeGazeAverage: CGPoint?
//
//
//}
//
//extension Array where Element == CGPoint {
//    var averagePoint: CGPoint {
//        var x: CGFloat = 0
//        var y: CGFloat = 0
//
//        for item in self {
//            x += item.x
//            y += item.y
//        }
//
//        let elementCount = CGFloat(self.count)
//        return CGPoint(x: CGFloat(x / elementCount), y: CGFloat(y / elementCount))
//    }
//}
