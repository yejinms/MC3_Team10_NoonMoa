import ARKit

struct EyeViewModel {
    var smileRight: Float = 0.0
    var smileLeft: Float = 0.0
    var blinkLeft: Float = 0.0
    var blinkRight: Float = 0.0
    var lookAtPoint: SIMD3 = SIMD3<Float>(0.0, 0.0, 0.0)
    var faceOrientation: SIMD3 = SIMD3<Float>(0.0, 0.0, 0.0)
    
    var savedLookAtPoint: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    var savedFaceOrientation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    
    mutating func update(faceAnchor: ARFaceAnchor) {
        let blendShapes = faceAnchor.blendShapes
        
        smileRight = Float(truncating: blendShapes.first(where: { $0.key == .mouthSmileRight })?.value ?? 0)
        smileLeft = Float(truncating: blendShapes.first(where: { $0.key == .mouthSmileLeft })?.value ?? 0)
        //blinkLeft가 오른쪽 눈임...이상하네
        blinkLeft = Float(truncating: blendShapes.first(where: { $0.key == .eyeBlinkLeft })?.value ?? 0)
        blinkRight = Float(truncating: blendShapes.first(where: { $0.key == .eyeBlinkRight })?.value ?? 0)

        //얼굴 방향과 상관 없이 x: 눈이 왼쪽일 때 음수, y: 눈이 아래일 때 음수, z: 화면과의 거리
        lookAtPoint = simd_float3(round(faceAnchor.lookAtPoint.x * 1000) / 1000, round(faceAnchor.lookAtPoint.y * 1000) / 1000, round(faceAnchor.lookAtPoint.z * 1000) / 1000)
        
        // .transform의 simd_float4x4의 column 0~3 중 column 2는 화면을 바라보는 축의 값이며, 그 중 x,y값은 사용자가 오른쪽 상단을 바라보았을 때 양수 값을 지닌다.
        faceOrientation = simd_float3(round(faceAnchor.transform.columns.2.x * 1000) / 1000, round(faceAnchor.transform.columns.2.y * 1000) / 1000, round(faceAnchor.transform.columns.2.z * 1000) / 1000)
    }
    var isSmiling: Bool {
        smileLeft > 0.3 || smileRight > 0.3
    }
    var isBlinkingLeft: Bool {
        blinkLeft > 0.8
    }
    var isBlinkingRight: Bool {
        blinkRight > 0.8
    }
    
}
