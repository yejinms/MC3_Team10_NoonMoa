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
    @Published var numberOfUpdates = 25
    @Published var eyeGazeAverage: CGPoint?
    

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
