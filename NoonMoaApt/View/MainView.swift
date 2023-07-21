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
    
    @StateObject var weather: WeatherViewModel
    @StateObject var time: TimeViewModel
    @StateObject var eyeTrack: EyeTrackViewModel

    var body: some View {
        switch viewRouter.currentView {
        case .login:
//            LoginView()
//                .environmentObject(LoginViewModel())
            CalendarMonthView()
        case .attendance:
            AttendanceView()
                .environmentObject(AttendanceViewModel())
        case .attendanceCompleted:
            let record = attendanceViewModel.ensureCurrentRecord()
            AttendanceCompletedView(record: record)
                .environmentObject(AttendanceCompletedViewModel(record: record))
        case .apt:
            AptView()
                .environmentObject(AptViewModel())
                .environmentObject(WeatherViewModel())
                .environmentObject(TimeViewModel())
        case .CalendarFull:
            CalendarFullView()
                .environmentObject(CalendarFullViewModel())
        case .CalendarSingle:
            CalendarSingleView()
                .environmentObject(calendarSingleController)
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
