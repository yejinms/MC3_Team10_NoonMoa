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
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var aptViewModel: AptViewModel
    @EnvironmentObject var eyeViewController: EyeViewController
    @State private var users: [[User]] = User.UTData
    @State private var buttonText: String = ""
    @State private var isCalendarOpen: Bool = false
    
    //아파트 등장 애니메이션
    @State private var isAptEffectPlayed: Bool = false
    
    //글자 타이핑 이펙트
    @State private var displayedText: String = ""
    @State private var fullText: String = ""
    let typingInterval = 0.15
    
    //임시변수
    @State private var isCalendarMonthOpen: Bool = false
    @State private var isCalendarDayOpen: Bool = false
    
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
//            FunctionTestView(buttonText: $buttonText)
//                .environmentObject(weather)
//                .environmentObject(time)
//            
            
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
            
            HStack {
                VStack(alignment: .leading) {
                    Spacer().frame(height: 56)
                    Text(displayedText)
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .shadow(color: .gray, radius: 6, x: 0, y: 4)
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 32)
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
        //안내방송
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                displayedText = ""
                fullText = "아,아...안내방송 드립니다.\n2023년 07월 27일\n오늘 날씨는 맑을 것으로 예상됩니다..."
                startTyping()
            }
        }
        .onChange(of: displayedText) { _ in
            if displayedText.count == fullText.count {
                withAnimation(.easeInOut(duration: 2).delay(2)) {
                    displayedText = ""
                }
            }
        }
    }

private func startTyping() {
    var currentIndex = 0
    let timer = Timer.scheduledTimer(withTimeInterval: typingInterval, repeats: true) { timer in
        if currentIndex < fullText.count {
            let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
            displayedText += String(fullText[index])
            currentIndex += 1
        } else {
            timer.invalidate()
        }
    }
    timer.fire()
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
