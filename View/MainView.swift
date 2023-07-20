//
//  MainView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject var attendanceCompletedViewModel : AttendanceCompletedViewModel
    @StateObject var attendanceViewModel : AttendanceViewModel
    @StateObject var calendarFullViewModel : CalendarFullViewModel
    @StateObject var calendarSingleController : CalendarSingleController
    @StateObject var loginViewModel : LoginViewModel
    @StateObject var aptViewModel : AptViewModel

    var body: some View {
        switch viewRouter.currentView {
        case .login:
            LoginView()
                .environmentObject(LoginViewModel())
        case .attendance:
            AttendanceView()
                .environmentObject(AttendanceViewModel())
        case .attendanceCompleted:
            if let record = attendanceViewModel.currentRecord {
                AttendanceCompletedView(record: record)
            }
        case .apt:
            AptView()
                .environmentObject(AptViewModel())
        case .CalendarFull:
            CalendarFullView()
                .environmentObject(CalendarFullViewModel())
        case .CalendarSingle:
            CalendarSingleView()
                .environmentObject(CalendarFullViewModel())
        default:
            LoginView()
                .environmentObject(LoginViewModel())
        }
    }
}


//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
