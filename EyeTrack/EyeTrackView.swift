//
//  EyeTrackView.swift
//  MC3
//
//  Created by 최민규 on 2023/07/19.
//

import SwiftUI
import ARKit
import RealityKit

struct EyeTrackView: View {
    @EnvironmentObject var eyeTrack: EyeTrackViewModel
    @State var viewModel = ARViewContainer.ViewModel()
    
    @State var eyeGazeActive: Bool = false
    @State var lookAtPoint: CGPoint?
    @State var isWinking: Bool = false
    @State var startPoint: CGPoint?
    @State var differencePoint: CGPoint?
    
    @State var eyeGazeAverage: CGPoint? = EyeTrackViewModel().eyeGazeHistory.suffix(EyeTrackViewModel().numberOfUpdates).averagePoint

    
    var body: some View {
        ZStack(alignment: .bottom) {
            CustomARViewContainer(eyeGazeActive: $eyeGazeActive, lookAtPoint: $lookAtPoint, isWinking: $isWinking, eyeGazeAverage: $eyeGazeAverage)
                .ignoresSafeArea()
            
//            VStack{
//                Text(startPoint.map { "Start Point: \(Int($0.x)), \(Int($0.y))" } ?? "")
//                    .foregroundColor(.white)
//                    .font(.body)
//                Text(lookAtPoint.map { "Look At Point: \(Int($0.x)), \(Int($0.y))" } ?? "")
//                    .foregroundColor(.white)
//                    .font(.body)
//                Text(differencePoint.map { "Difference: \(Int($0.x)), \(Int($0.y))" } ?? "")
//                    .foregroundColor(.white)
//                    .font(.body)
//            }
//            .offset(y: -300)
            
            Button(action: {
                if eyeGazeActive {
                    startPoint = nil
                    differencePoint = nil
                } else {
                    startPoint = lookAtPoint
                }
                eyeGazeActive.toggle()
            }, label: {
                Text(eyeGazeActive ? "Stop" : "Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding(.bottom, 50)
            
            if let lookAtPoint = lookAtPoint {
                Circle()
                    .fill(Color.blue)
                    .frame(width: isWinking ? 120 : 80, height: isWinking ? 120 : 80)
                    .overlay(
                        Text("")
                            .foregroundColor(.white)
                            .font(.body)
                    )
                    .position(lookAtPoint)
                    
            }
        }
//        .onChange(of: lookAtPoint) { points in
//            guard eyeGazeActive else { return }
//
//            differencePoint = CGPoint(
//                x: (lookAtPoint?.x ?? 0) - (startPoint?.x ?? 0),
//                y: (lookAtPoint?.y ?? 0) - (startPoint?.y ?? 0)
//            )
//        }

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


struct EyeTrackView_Previews: PreviewProvider {
    static var previews: some View {
        EyeTrackView()
            .environmentObject(EyeTrackViewModel())
    }
}
