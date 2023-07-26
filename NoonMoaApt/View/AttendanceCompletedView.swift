//
//  AttendanceCompletedView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import SwiftUI
import Firebase

struct AttendanceCompletedView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var attendanceCompletedViewModel: AttendanceCompletedViewModel
    @StateObject private var viewModel: AttendanceCompletedViewModel
    
    init(record: AttendanceRecord) {
        _viewModel = StateObject(wrappedValue: AttendanceCompletedViewModel(record: record))
    }
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack (alignment: .leading) {
                    
                    // 페페의 데이터 확인용 코드
                    /*
                     Text("Attendance Complete!")
                     HStack {
                     Button {
                     viewRouter.currentView = .attendance
                     } label: {
                     Text("다시 찍기")
                     }
                     
                     Button("시작하기") {
                     attendanceCompletedViewModel.saveAttendanceRecord()
                     attendanceCompletedViewModel.updateUserLastActiveDate()
                     viewRouter.currentView = .apt
                     }
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
                    
                    StampLDesign(isAttendanceView: true, isStamped: true)
                    
                    Spacer()
                    
                    HStack {
                        // 눈도장 찍기 버튼
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .fill(Color.warmBlack)
                                    .frame(height: geo.size.height * 0.066, alignment: .center)
                                    .padding(.leading, geo.size.width * 0.07)
                                Text("다시 찍기")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                        // 눈도장 찍기 버튼
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13)
                                    .fill(Color.warmBlack)
                                    .frame(height: geo.size.height * 0.066, alignment: .center)
                                    .padding(.trailing, geo.size.width * 0.07)
                                Text("시작하기")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding(.bottom, geo.size.height * 0.07)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct AttendanceCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock AttendanceRecord object
        let eyeDirections: [Float] = [0.5, 0.5, 0.5]
        let record = AttendanceRecord(userId: "test", date: Date(), weatherCondition: "clear", eyeDirection: eyeDirections)
        
        // Create and configure an instance of the ViewRouter and MidnightUpdater
        let viewRouter = ViewRouter()
        let viewModel = AttendanceCompletedViewModel(record: record)
        
        // Provide these instances to the view
        AttendanceCompletedView(record: record)
            .environmentObject(viewRouter)
            .environmentObject(viewModel)
    }
}
