import ARKit

class EyeViewController: NSObject, ObservableObject {
    @Published var eyeModel = EyeViewModel()
    
    var session = ARSession()

    override init() {
        super.init()
        session.run(ARFaceTrackingConfiguration())
        session.delegate = self
    }
    
    //TODO: 제대로 작동하는지 확인할 것
    func resetFaceAnchor() {
        session.pause()
        for anchor in session.currentFrame?.anchors ?? [] {
                   session.remove(anchor: anchor)
               }
        session.run(ARFaceTrackingConfiguration())
    }
    
}

extension EyeViewController: ARSessionDelegate {
    func session(_: ARSession, didUpdate anchors: [ARAnchor]) {
        if let faceAnchor = anchors.first as? ARFaceAnchor {
            eyeModel.update(faceAnchor: faceAnchor)
        }
    }
}
