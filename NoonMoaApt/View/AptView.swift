//
//  ApartView.swift
//  MC3
//
//  Created by 최민규 on 2023/07/14.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AptView: View {
    @EnvironmentObject var weather: WeatherViewModel
    @EnvironmentObject var time: TimeViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var aptViewModel: AptViewModel
    @EnvironmentObject var eyeViewController: EyeViewController
    @State private var users: [[User]] = User.sampleData
    @State private var buttonText: String = ""
    @State private var isCalendarOpen: Bool = false
    
    //임시변수
    @State private var isCalendarMonthOpen: Bool = false
    @State private var isCalendarDayOpen: Bool = false


    @State private var isAptEffectPlayed: Bool = false
    
    private var firestoreManager: FirestoreManager {
        FirestoreManager.shared
    }
    private var db: Firestore {
        firestoreManager.db
    }
    
    var body: some View {
        ZStack{
            //배경 레이어
            SceneBackground()
                .environmentObject(weather)
                .environmentObject(time)
                .scaleEffect(isAptEffectPlayed ? 1 : 1.3)
            
            //아파트 레이어
            GeometryReader { proxy in
                ZStack {
                    GeometryReader { geo in
                        SceneApt()
                        VStack(spacing: 16) {
                            ForEach(users.indices, id: \.self) { rowIndex in
                                HStack(spacing: 12) {
                                    ForEach(users[rowIndex].indices, id: \.self) { userIndex in
                                        SceneRoom(roomUser: $users[rowIndex][userIndex])
                                            .environmentObject(eyeViewController)
                                            .frame(width: (geo.size.width - 48) / 3, height: ((geo.size.width - 48) / 3) / 1.2)
                                    }
                                }
                            }
                        }
                        .offset(x: 12, y: 32)
                    }//GeometryReader
                }//ZStack
                .padding()
                .ignoresSafeArea()
                .offset(y: proxy.size.height - proxy.size.width * 1.5)
                //화면만큼 내린 다음에 아파트 크기 비율인 1:1.5에 따라 올려 보정?
            }
            .scaleEffect(isAptEffectPlayed ? 1 : 1.3)
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    isAptEffectPlayed = true
                }
            }
            
            //날씨 레이어
            SceneWeather()
                .environmentObject(weather)
                .environmentObject(time)
                .opacity(isAptEffectPlayed ? 1 : 0.5)
            
            //버튼 레이어
            GeometryReader { proxy in
                ZStack {
                    GeometryReader { geo in
                        VStack(spacing: 16) {
                            ForEach(users.indices, id: \.self) { rowIndex in
                                HStack(spacing: 12) {
                                    ForEach(users[rowIndex].indices, id: \.self) { userIndex in
                                        
                                        SceneButtons(roomUser: $users[rowIndex][userIndex], buttonText: $buttonText).environmentObject(weather)
                                            .frame(width: (geo.size.width - 48) / 3, height: ((geo.size.width - 48) / 3) / 1.2)
                                        //방 이미지 자체의 비율 1:1.2 통한 높이 산정
                                    }
                                }
                            }
                        }
                        .offset(x: 12, y: 32)
                    }//GeometryReader
                }//ZStack
                .padding()
                .ignoresSafeArea()
                .offset(y: proxy.size.height - proxy.size.width * 1.5)
                //화면만큼 내린 다음에 아파트 크기 비율인 1:1.5에 따라 올려 보정?
            }
            
            //기능테스트위한 임시 뷰
            FunctionTestView(buttonText: $buttonText)
                .environmentObject(weather)
                .environmentObject(time)
            
            
            //임시코드
            Image("CalendarMonth_Temp")
                .resizable()
                .ignoresSafeArea()
                .onTapGesture {
                    isCalendarMonthOpen = false
                    isCalendarDayOpen = true
                }
                .overlay( // 외부 공간 눌렀을 때 캘린더 닫힘
                    Color.white
                        .frame(height: 400)
                    .offset(y: 270)
                    .opacity(0.01)
                    .onTapGesture {
                        isCalendarMonthOpen = false
                        isCalendarDayOpen = false
                        isCalendarOpen = false
                    }
                )
                .opacity(isCalendarMonthOpen ? 1 : 0)

            Image("CalendarDay_Temp")
                .resizable()
                .ignoresSafeArea()
                .onTapGesture {
                    isCalendarMonthOpen = true
                    isCalendarDayOpen = false
                }
                .overlay( // 외부 공간 눌렀을 때 캘린더 닫힘
                    Color.white
                    .frame(height: 400)
                    .offset(y: 270)
                    .opacity(0.01)
                    .onTapGesture {
                        isCalendarMonthOpen = false
                        isCalendarDayOpen = false
                        isCalendarOpen = false
                    }
                )
                .opacity(isCalendarDayOpen ? 1 : 0)
            
            // 상단 캘린더 & 설정 버튼
            GeometryReader { proxy in
                HStack (spacing: 16) {
                    Spacer()
                    
                    Button { // 캘린더 버튼
                            if isCalendarOpen {
                                isCalendarOpen = false
                                isCalendarMonthOpen = false
                                isCalendarDayOpen = false
                            } else {
                                isCalendarOpen = true
                                isCalendarMonthOpen = true
                                isCalendarDayOpen = false
                            }
                    } label: {
                        if isCalendarOpen {
                            Image("calendar_selected")
                                .resizable()
                                .scaledToFit()
                                .frame(width: proxy.size.width * 0.08)
                        } else {
                            Image("calendar_unselected")
                                .resizable()
                                .scaledToFit()
                                .frame(width: proxy.size.width * 0.08)
                        }
                    }
                    
                    Button { // 설정 버튼
                        
                    } label: {
                        Image("settings_unselected")
                            .resizable()
                            .scaledToFit()
                            .frame(width: proxy.size.width * 0.08)
                    }
                }
                .padding(.trailing, proxy.size.width * 0.06)
            }
//            CalendarMonthView(isCalendarOpen: $isCalendarOpen)
//                .frame(height: 400)
//                .opacity(isCalendarOpen ? 1 : 0)
        }//ZStack
        .onAppear {
            aptViewModel.fetchCurrentUserApt()
            if let user = Auth.auth().currentUser {
                firestoreManager.syncDB()
                let userRef = db.collection("User").document(user.uid)
                
                userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let userData = document.data(), let userState = userData["userState"] as? String {
                            print("AppDelegate | handleSceneActive | userState: \(userState)")
                            self.db.collection("User").document(user.uid).updateData([
                                "userState": UserState.active.rawValue
                            ])
                        }
                    } else {
                        print("No user is signed in.")
                    }
                }
            }
        }
    }
}

struct AptView_Previews: PreviewProvider {
    static var previews: some View {
        AptView()
            .environmentObject(WeatherViewModel())
            .environmentObject(TimeViewModel())
            .environmentObject(ViewRouter())
            .environmentObject(AptViewModel())
            .environmentObject(EyeViewController())
    }
}
