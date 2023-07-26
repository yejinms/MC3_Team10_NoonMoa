////
////  AttendanceCompletedView.swift
////  MangMongApt
////
////  Created by kimpepe on 2023/07/15.
////
//
//import SwiftUI
//import Firebase
//
//struct AttendanceCompletedView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//    @EnvironmentObject var attendanceCompletedViewModel: AttendanceCompletedViewModel
//    @StateObject private var viewModel: AttendanceCompletedViewModel
//    var pushNotiController = PushNotiController()
//    
//    @EnvironmentObject var midnightUpdater: MidnightUpdater
//
//    private var userTokenArr : [String] = ["cRRGWtqBU0bUg2JHqjHzfL:APA91bGiiIRQ5w2Wze1fAs149fwaymbjS-pU4z4HUlVD4sThpwwPzWjuVkXTrWPfuA-qEuuy34Ex5bR2sZFqAicAoZmKdFv5SsObHSwLWHvms3SmJ9jU9VF7qY2LOTdSbQXtbPA9KsDC"]
//    
//    private var title: String = "title: [충격] 아무도 몰랐던 천재 헨리의 사생활..."
//    private var content: String = "content: 매일 매일 닭가슴살 5개씩 섭취하는 것으로 밝혀져..."
//    
//    init(record: AttendanceRecord) {
//        _viewModel = StateObject(wrappedValue: AttendanceCompletedViewModel(record: record))
//    }
//    
//    var body: some View {
//
//        VStack {
//            GeometryReader { geo in
//                VStack (alignment: .leading) {
//                    
//                    // 페페의 데이터 확인용 코드
//                    /*
//                     Text("Attendance Complete!")
//                     HStack {
//                     Button {
//                     viewRouter.currentView = .attendance
//                     } label: {
//                     Text("다시 찍기")
//                     }
//                     
//                     Button("시작하기") {
//                     attendanceCompletedViewModel.saveAttendanceRecord()
//                     attendanceCompletedViewModel.updateUserLastActiveDate()
//                     viewRouter.currentView = .apt
//                     }
//                     }
//                     */
//                    
//                    // 멘트 글씨 Group
//                    VStack (alignment: .leading) {
//                        Text("dddd")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .padding(.bottom, geo.size.height * 0.008)
//                        Text("aaaaa")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                    }
//                    .padding(.top, geo.size.height * 0.15)
//                    .padding(.leading, geo.size.width * 0.07)
//                    
//                    Spacer()
//                    
////                    StampLDesign(isAttendanceView: true, isStamped: true)
//                    
//                    Spacer()
//                    
//                    HStack {
//                        // 눈도장 찍기 버튼
//                        Button {
//                            
//                        } label: {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 13)
//                                    .fill(Color.warmBlack)
//                                    .frame(height: geo.size.height * 0.066, alignment: .center)
//                                    .padding(.leading, geo.size.width * 0.07)
//                                Text("다시 찍기")
//                                    .foregroundColor(.white)
//                                    .fontWeight(.semibold)
//                            }
//                        }
//                        // 눈도장 찍기 버튼
//                        Button {
//                            
//                        } label: {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 13)
//                                    .fill(Color.warmBlack)
//                                    .frame(height: geo.size.height * 0.066, alignment: .center)
//                                    .padding(.trailing, geo.size.width * 0.07)
//                                Text("시작하기")
//                                    .foregroundColor(.white)
//                                    .fontWeight(.semibold)
//                            }
//                        }
//                    }
//                    .padding(.bottom, geo.size.height * 0.07)
//                }
//            }
//            .ignoresSafeArea()
//        }
//    }
//}
//
//struct AttendanceCompletedView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a mock AttendanceRecord object
//        let eyeDirections: [Float] = [0.5, 0.5, 0.5]
//        let record = AttendanceRecord(userId: "test", date: Date(), weatherCondition: "clear", eyeDirection: eyeDirections)
//        
//        // Create and configure an instance of the ViewRouter and MidnightUpdater
//        let viewRouter = ViewRouter()
//        let viewModel = AttendanceCompletedViewModel(record: record)
//        
//        // Provide these instances to the view
//        AttendanceCompletedView(record: record)
//            .environmentObject(viewRouter)
//            .environmentObject(viewModel)
//    }
//}
