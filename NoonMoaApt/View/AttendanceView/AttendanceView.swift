//
//  AttendanceView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AttendanceView: View {
    private let currentUser = Auth.auth().currentUser
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    @EnvironmentObject var customViewModel: CustomViewModel
    @EnvironmentObject var eyeViewController: EyeViewController
    
    @State private var isStamped: Bool = false
    @State private var isScaleEffectPlayed: Bool = false
    @State private var isBlurEffectPlayed: Bool = false
    @State private var isShutterEffectPlayed: Bool = false
    
    @State private var savedSkyColor: LinearGradient = Color.sky.clearDay
    @State private var savedSkyImage: Image = Image.assets.largeStamp.clearDay
    @State private var savedIsSmiling: Bool = false
    @State private var savedIsBlinkingLeft: Bool = false
    @State private var savedIsBlinkingRight: Bool = false
    @State private var savedLookAtPoint: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var savedFaceOrientation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var savedBodyColor: LinearGradient = .userBlue
    @State private var savedEyeColor: LinearGradient = .eyeBlue
    
    private var firestoreManager: FirestoreManager {
        FirestoreManager.shared
    }
    private var db: Firestore {
        firestoreManager.db
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Spacer().frame(height: geo.size.height * 0.06)
                    HStack {
                        VStack(alignment: .leading) {
                            if !isStamped {
                                Text("좋은 아침이에요!")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 4)
                                Text("매일 눈을 뜬다는 건 멋진 일이예요.\n오늘의 시작을 기록해주세요.")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            } else {
                                Text("오늘은 날씨가 꽤나 맑군요")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 4)
                                Text("오늘 하루도 상쾌하길 바라요!")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                        }
                    }
                    .frame(height: geo.size.height * 0.16)
                    .offset(x: 8)
                    
                    Spacer()
                    
                    if !isStamped {
                        //출석체크 전 눈 움직이는 뷰
                        StampLargeView(skyColor: Color.gradationGray, skyImage: Image(""), isSmiling: eyeViewController.eyeMyModel.isSmiling,
                                       isBlinkingLeft: eyeViewController.eyeMyModel.isBlinkingLeft,
                                       isBlinkingRight: eyeViewController.eyeMyModel.isBlinkingRight,
                                       lookAtPoint: eyeViewController.eyeMyModel.lookAtPoint,
                                       faceOrientation: eyeViewController.eyeMyModel.faceOrientation,
                                       bodyColor: LinearGradient.unStampedWhite,
                                       eyeColor: LinearGradient.unStampedWhite, cheekColor: LinearGradient.cheekGray)
                        .frame(width: geo.size.width, height: geo.size.width)
                        .offset(y: -16)
                        .blur(radius: isBlurEffectPlayed ? 5 : 0)
                        .onTapGesture {
                            eyeViewController.resetFaceAnchor()
                        }
                        
                    } else {
                        //출석체크 후 저장된 날씨와, 캐릭터의 움직임 좌표값으로 표현된 뷰
                        StampLargeView(skyColor: savedSkyColor, skyImage: savedSkyImage, isSmiling: savedIsSmiling, isBlinkingLeft: savedIsBlinkingLeft, isBlinkingRight: savedIsBlinkingRight, lookAtPoint: savedLookAtPoint, faceOrientation: savedFaceOrientation, bodyColor: savedBodyColor, eyeColor: savedEyeColor, cheekColor: LinearGradient.cheekRed)
                            .frame(width: geo.size.width, height: geo.size.width)
                            .offset(y: -16)
                            .scaleEffect(isScaleEffectPlayed ? 0.9 : 1)
                            .opacity(isShutterEffectPlayed ? 1 : 0)
                        
                    }
                    
                    Spacer()
                    
                    if !isStamped {
                        // 눈도장 찍기 버튼
                        Button (action: {
                            DispatchQueue.main.async {
                                withAnimation(.easeInOut(duration: 0.2).repeatCount(1, autoreverses: true)) {
                                    isBlurEffectPlayed = true
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.4).repeatCount(1, autoreverses: true)) {
                                    isBlurEffectPlayed = false
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    isStamped = true
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.linear.speed(1.5).repeatCount(1, autoreverses: true)) {
                                    isShutterEffectPlayed = true
                                }
                                
                                //weather뷰모델에 현재 날씨를 실행시키고, 그에 따라 배경 정보를 저장한다.
                                
//                                self.savedSkyColor = custo
//                                self.savedSkyImage = weatherViewModel.savedSkyImage
                                //ARView에서 움직이던 값을 저장한다.
                                self.savedIsSmiling = eyeViewController.eyeMyViewModel.isSmiling
                                self.savedIsBlinkingLeft = eyeViewController.eyeMyViewModel.isBlinkingLeft
                                self.savedIsBlinkingRight = eyeViewController.eyeMyViewModel.isBlinkingRight
                                self.savedLookAtPoint = eyeViewController.eyeMyViewModel.lookAtPoint
                                self.savedFaceOrientation = eyeViewController.eyeMyViewModel.faceOrientation
                                self.savedBodyColor = eyeViewController.eyeMyViewModel.bodyColor
                                self.savedEyeColor = eyeViewController.eyeMyViewModel.eyeColor
                                
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.3).speed(1)) {
                                    isScaleEffectPlayed = true
                                }
                            }
                            
                        }) {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.warmBlack)
                                .frame(height: 56)
                                .overlay(
                                    Text("눈도장 찍기")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .padding()
                                )
                        }
                    } else {
                        HStack {
                            // 다시찍기 버튼
                            Button (action: {
                                isStamped = false
                                isScaleEffectPlayed = false
                                isBlurEffectPlayed = false
                                isShutterEffectPlayed = false
                            }) {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.warmBlack)
                                    .frame(height: 56)
                                    .overlay(
                                        Text("다시 찍기")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                            .padding()
                                    )
                            }
                            // 시작하기 버튼
                            Button (action: {
                                //TODO: AttendanceCompleteViewModel에 정보를 저장합니다.
                                viewRouter.currentView = .apt
                                attendanceCompletedViewModel.saveAttendanceRecord(record: regenAttendanceRecord())
//                                아래는 실행되지 않을 것임
                                attendanceCompletedViewModel.updateUserLastActiveDate()
                            }) {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.warmBlack)
                                    .frame(height: 56)
                                    .overlay(
                                        Text("시작하기")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                            .padding()
                                    )
                            }
                        }//HStack
                    }
                }//VStack
            }//GeometryReader
            .padding(24)
        }//ZStack
    }
    func regenAttendanceRecord() -> AttendanceRecord {
        
        firestoreManager.syncDB()
        // Get the emptyRooms document
//        let emptyRoomsRef = db.collection("User").document("emptyRooms")
//        emptyRoomsRef.getDocument { (document, error) in
            
        let userId = "\(currentUser?.uid ?? "")"
        let weatherCondition = weatherViewModel.currentWeather
        let eyeDirection = [savedFaceOrientation.x, savedFaceOrientation.y, savedFaceOrientation.z]
        
        return AttendanceRecord(userId: userId, date: Date(), weatherCondition: weatherCondition, eyeDirection: eyeDirection)
    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
            .environmentObject(ViewRouter())
            .environmentObject(AttendanceViewModel())
            .environmentObject(CustomViewModel())
            .environmentObject(EyeViewController())
    }
}
