//
//  AttendanceView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import WeatherKit

struct AttendanceView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    
    private let currentUser = Auth.auth().currentUser
    var stampPressed: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .leading) {
                
                // 페페의 데이터 확인용 코드
                /*
                Text("Hello, \(currentUser?.uid ?? "NoBody")")
                Text("Weather: \(attendanceViewModel.weatherCondition)")
                Text("Eye Direction: \(attendanceViewModel.eyeDirection.map{ String($0) }.joined(separator: ", "))")
                Image(systemName: "tree")
                    .frame(width: 150, height: 150)
                
                Button("Complete Attendance") {
                    attendanceViewModel.createAttendanceRecord()
                    viewRouter.currentView = .attendanceCompleted
                }
                */
                
                // 멘트 글씨 Group
                VStack (alignment: .leading) {
                    Text("\(mainSentence())")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, geo.size.height * 0.008)
                    Text("\(subSentence())")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.top, geo.size.height * 0.15)
                .padding(.leading, geo.size.width * 0.07)
                
                Spacer()
                
                StampLDesign(isAttendanceView: true, isStamped: false)
                
                Spacer()
                
                // 눈도장 찍기 버튼
                Button {
                    attendanceViewModel.createAttendanceRecord()
                    viewRouter.currentView = .attendanceCompleted
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .fill(Color.warmBlack)
                            .frame(height: geo.size.height * 0.066, alignment: .center)
                            .padding(.horizontal, geo.size.width * 0.07)
                        Text("눈도장 찍기")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, geo.size.height * 0.07)

            }
        }
        .ignoresSafeArea()
    }
}

func mainSentence() -> String {
    @StateObject var time: TimeViewModel = TimeViewModel()
    var sentence: String = ""
    
        if time.isDayTime {
            sentence = "좋은 아침이에요!"
        } else {
            sentence = "기분 좋은 오후군요!"
        }
    return sentence
}

func subSentence() -> String {
    @StateObject var time: TimeViewModel = TimeViewModel()
    var sentence: String = ""
        
    if time.isDayTime {
        sentence = "매일 눈을 뜬다는 건 멋진 일이에요.\n눈도장으로 하루의 시작을 기록해주세요."
    } else {
        sentence = "오늘은 왠지 좋은 일이 생길 것 같아요.\n이 기분을 그대로 눈도장으로 남겨볼까요?"
    }
    return sentence
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        // chatGPT needed
        AttendanceView()
    }
}
