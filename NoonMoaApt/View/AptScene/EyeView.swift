import SwiftUI

struct EyeView: View {
    
    var isSmiling: Bool
    var isBlinkingLeft: Bool
    var isBlinkingRight: Bool
    var lookAtPoint: SIMD3<Float>
    var faceOrientation: SIMD3<Float>
    
    var body: some View {
        GeometryReader { geo in
            
            let bodyWidth = geo.size.width
            let bodyHeight = bodyWidth * 0.88
            let eyeWidth = bodyWidth * 0.25
            let eyeHeight = bodyHeight * 0.50
            let eyeBallWidth = eyeWidth * 0.50
            let eyeBallHeight = eyeHeight * 0.32
            let eyeDistance = bodyWidth * 0.01
            
            let eyeLimitFrameWidth = bodyWidth * 0.80
            let eyeLimitFrameHeight = bodyHeight * 0.80
            let eyeBallLimitFrameWidth = eyeWidth * 0.90
            let eyeBallLimitFrameHeight = eyeHeight * 0.70
            let eyeHorizontalLimit = (eyeLimitFrameWidth - eyeWidth * 2 - eyeDistance) / 2
            let eyeVerticalLimit =  (eyeLimitFrameHeight - eyeHeight) / 2
            let eyeBallHorizontalLimit = (eyeBallLimitFrameWidth - eyeBallWidth) / 2
            let eyeBallVerticalLimit = (eyeBallLimitFrameHeight - eyeBallHeight) / 2
            let eyeOffsetX = min(max(CGFloat(faceOrientation.x) * 15 , -eyeHorizontalLimit), eyeHorizontalLimit)
            let eyeOffsetY = min(max(CGFloat(faceOrientation.y) * 80 , -eyeVerticalLimit), eyeVerticalLimit)
            let eyeBallOffsetX = min(max(CGFloat(lookAtPoint.x * 100) , -eyeBallHorizontalLimit), eyeBallHorizontalLimit)
            let eyeBallOffsetY = min(max(CGFloat(lookAtPoint.y * 100) , -eyeBallVerticalLimit), eyeBallVerticalLimit)
            
            let shadowWidth = bodyWidth * 0.80
            let shadowHeight = bodyHeight * 0.15
            
            ZStack {
                Ellipse()
                    .fill(LinearGradient(colors: [Color(hex: 0xF2F2F2), Color(hex: 0xD9D9D9)], startPoint: .top, endPoint: .bottom))
                    .frame(width: shadowWidth, height: shadowHeight)
                    .offset(y: bodyHeight / 2)
                    .opacity(0.7)
                
                Ellipse()
                    .fill(LinearGradient(colors: [Color(hex: 0xD9D9D9), Color(hex: 0xF2F2F2)], startPoint: .top, endPoint: .bottom))
                    .overlay(
                        Ellipse()
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(width: bodyWidth, height: bodyHeight)
                    .overlay(
                        HStack(spacing: eyeDistance) {
                            //왼쪽 눈
                            Ellipse()
                                .fill(Color.white)
                                .overlay(
                                    Ellipse()
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .frame(width: eyeWidth, height: eyeHeight)
                                .overlay(
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: eyeBallWidth, height: eyeBallHeight)
                                        .offset(x: eyeOffsetX, y: eyeOffsetY)
                                )
                                .clipShape(Ellipse())
                                .offset(x: eyeBallOffsetX, y: eyeBallOffsetY)
                                .opacity(isBlinkingRight ? 0 : 1)
                            //오른쪽 눈
                            Ellipse()
                                .fill(Color.white)
                                .overlay(
                                    Ellipse()
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .frame(width: eyeWidth, height: eyeHeight)
                                .overlay(
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: eyeBallWidth, height: eyeBallHeight)
                                        .offset(x: eyeOffsetX, y: eyeOffsetY)
                                )
                                .clipShape(Ellipse())
                                .offset(x: eyeBallOffsetX, y: eyeBallOffsetY)
                                .opacity(isBlinkingRight ? 0 : 1)
                        }
                    )
                    .clipShape(Ellipse())
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }//GeometryReader
    }
}


struct TestView: View {
    @ObservedObject var eyeViewController = EyeViewController()
    
    var body: some View {
        
        EyeTestView(isSmiling: eyeViewController.eyeModel.isSmiling,
                    isBlinkingLeft: eyeViewController.eyeModel.isBlinkingLeft,
                    isBlinkingRight: eyeViewController.eyeModel.isBlinkingRight,
                    lookAtPoint: eyeViewController.eyeModel.lookAtPoint,
                    faceOrientation: eyeViewController.eyeModel.faceOrientation)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct EyeTestView: View {
    
    var isSmiling: Bool
    var isBlinkingLeft: Bool
    var isBlinkingRight: Bool
    var lookAtPoint: SIMD3<Float>
    var faceOrientation: SIMD3<Float>
    
    var body: some View {
        ZStack {
            VStack {
                Text(isSmiling ? "Smiling 😄" : "Not Smiling 😐")
                    .padding()
                    .foregroundColor(isSmiling ? .green : .red)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
                Button(action: {EyeViewController().resetFaceAnchor()}) {
                    Text("reset")
                        .padding()
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
                    
                }
                Text("lookAtPoint x: \(Int(round(lookAtPoint.x * 1000))), y: \(Int(round(lookAtPoint.y * 1000))), z: \(Int(round(lookAtPoint.z * 1000)))")
                Text("faceOrientation x: \(Int(round(faceOrientation.x * 1000))), y: \(Int(round(faceOrientation.y * 1000))), z: \(Int(round(faceOrientation.z * 1000)))")
                Text("x: \(CGFloat(Int(round(faceOrientation.x * 100)))), y: \(-CGFloat(Int(round(faceOrientation.y * 100))))")
                Spacer()
            }
            
            GeometryReader { geo in
                
                let bodyWidth = geo.size.width
                let bodyHeight = bodyWidth * 0.88
                let eyeWidth = bodyWidth * 0.25
                let eyeHeight = bodyHeight * 0.50
                let eyeBallWidth = eyeWidth * 0.50
                let eyeBallHeight = eyeHeight * 0.32
                let eyeDistance = bodyWidth * 0.01
                
                let eyeLimitFrameWidth = bodyWidth * 0.85
                let eyeLimitFrameHeight = bodyHeight * 0.75
                let eyeBallLimitFrameWidth = eyeWidth * 0.90
                let eyeBallLimitFrameHeight = eyeHeight * 0.70
                let eyeHorizontalLimit = (eyeLimitFrameWidth - eyeWidth * 2 - eyeDistance) / 2
                let eyeVerticalLimit =  (eyeLimitFrameHeight - eyeHeight) / 2
                let eyeBallHorizontalLimit = (eyeBallLimitFrameWidth - eyeBallWidth) / 2
                let eyeBallVerticalLimit = (eyeBallLimitFrameHeight - eyeBallHeight) / 2
                let eyeOffsetX = min(max(CGFloat(faceOrientation.x) * bodyWidth * 0.6, -eyeHorizontalLimit), eyeHorizontalLimit)
                let eyeOffsetY = -min(max(CGFloat(faceOrientation.y) * bodyWidth * 0.6, -eyeVerticalLimit), eyeVerticalLimit)
                let eyeBallOffsetX = min(max(CGFloat(lookAtPoint.x) * bodyWidth * 0.3, -eyeBallHorizontalLimit), eyeBallHorizontalLimit)
                let eyeBallOffsetY = -min(max(CGFloat(lookAtPoint.y) * bodyWidth * 0.6, -eyeBallVerticalLimit), eyeBallVerticalLimit)
                
                let shadowWidth = bodyWidth * 0.80
                let shadowHeight = bodyHeight * 0.15
                
                ZStack {
                    Ellipse()
                        .fill(LinearGradient(colors: [Color(hex: 0x999999), Color(hex: 0x000000)], startPoint: .top, endPoint: .bottom))
                        .frame(width: shadowWidth, height: shadowHeight)
                        .offset(y: bodyHeight / 2)
                        .opacity(0.4)
                    
                    Ellipse()
                        .fill(LinearGradient(colors: [Color(hex: 0xD9D9D9), Color(hex: 0xF2F2F2)], startPoint: .top, endPoint: .bottom))
                        .overlay(
                            Ellipse()
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .frame(width: bodyWidth, height: bodyHeight)
                        .overlay(
                            HStack(spacing: eyeDistance) {
                                //왼쪽 눈
                                Ellipse()
                                    .fill(Color.white)
                                    .overlay(
                                        Ellipse()
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .frame(width: eyeWidth, height: eyeHeight)
                                    .overlay(
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: eyeBallWidth, height: eyeBallHeight)
                                            .offset(x: eyeBallOffsetX, y: eyeBallOffsetY)
                                    )
                                    .clipShape(Ellipse())
                                    .offset(x: eyeOffsetX, y: eyeOffsetY)
                                    .opacity(isBlinkingRight ? 0 : 1)

                                //오른쪽 눈
                                Ellipse()
                                    .fill(Color.white)
                                    .overlay(
                                        Ellipse()
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .frame(width: eyeWidth, height: eyeHeight)
                                    .overlay(
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: eyeBallWidth, height: eyeBallHeight)
                                            .offset(x: eyeBallOffsetX, y: eyeBallOffsetY)
                                    )
                                    .clipShape(Ellipse())
                                    .offset(x: eyeOffsetX, y: eyeOffsetY)
                                    .opacity(isBlinkingLeft ? 0 : 1)
                            }
                        )
                        .clipShape(Ellipse())
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            }//GeometryReader
            .padding()
        }//ZStack
    }
}
