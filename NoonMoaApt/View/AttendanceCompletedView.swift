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
    var pushNotiController = PushNotiController()
    
    @EnvironmentObject var midnightUpdater: MidnightUpdater

    private var userTokenArr : [String] = ["cRRGWtqBU0bUg2JHqjHzfL:APA91bGiiIRQ5w2Wze1fAs149fwaymbjS-pU4z4HUlVD4sThpwwPzWjuVkXTrWPfuA-qEuuy34Ex5bR2sZFqAicAoZmKdFv5SsObHSwLWHvms3SmJ9jU9VF7qY2LOTdSbQXtbPA9KsDC"]
    
    private var title: String = "title: [충격] 아무도 몰랐던 천재 헨리의 사생활..."
    private var content: String = "content: 매일 매일 닭가슴살 5개씩 섭취하는 것으로 밝혀져..."
    
    init(record: AttendanceRecord) {
        _viewModel = StateObject(wrappedValue: AttendanceCompletedViewModel(record: record))
    }
    
    var body: some View {
        
// 모든 User 상태를 .sleep로 바꾸는 버튼
//        Button(action: {
//            self.midnightUpdater.updateAllUsersToSleep()
//        }) {
//            Text("Test Sleep Update")
//        }
        
        Button {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                for userToken in userTokenArr {
                    pushNotiController.sendPushNotification(userToken: userToken, title: title, content: content)
                }
            }
        } label: {
            Text("user B에게 push noti 보내기")
        }
        
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
    }
}


// You also need to add a property wrapper for AppDelegate
extension EnvironmentValues {
    var appDelegate: AppDelegate {
        get { self[AppDelegateKey.self] }
        set { self[AppDelegateKey.self] = newValue }
    }
}

private struct AppDelegateKey: EnvironmentKey {
    static var defaultValue: AppDelegate = AppDelegate()
}
