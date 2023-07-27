//
//  MainView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject var attendanceCompletedViewModel: AttendanceCompletedViewModel
    @StateObject var attendanceViewModel: AttendanceViewModel
    @StateObject var calendarFullViewModel: CalendarFullViewModel
    @StateObject var calendarSingleController: CalendarSingleController
    @StateObject var loginViewModel: LoginViewModel
    @StateObject var aptViewModel: AptViewModel
    
    @StateObject var weatherViewModel: WeatherViewModel
    @StateObject var timeViewModel: TimeViewModel
    @StateObject var eyeViewController: EyeViewController
    
    var body: some View {
        
        switch viewRouter.currentView {
        case .launchScreen:
            launchScreenView()
        case .onBoarding:
            OnboardingView()
                .environmentObject(viewRouter)
        case .login:
            LoginView()
                .environmentObject(LoginViewModel(viewRouter: ViewRouter()))
        case .attendance:
            let record = attendanceViewModel.ensureCurrentRecord()
            AttendanceView(record: record)
                .environmentObject(attendanceViewModel)
                .environmentObject(weatherViewModel)
                .environmentObject(timeViewModel)
                .environmentObject(eyeViewController)
                .environmentObject(AttendanceCompletedViewModel(record: record))

            
            //        case .attendanceCompleted:
            //            let record = attendanceViewModel.ensureCurrentRecord()
            //            AttendanceCompletedView(record: record)
            //                .environmentObject(AttendanceCompletedViewModel(record: record))
        case .apt:
            AptView()
                .environmentObject(aptViewModel)
                .environmentObject(weatherViewModel)
                .environmentObject(timeViewModel)
                .environmentObject(eyeViewController)
            
        case .CalendarFull:
            CalendarFullView()
                .environmentObject(CalendarFullViewModel())
        case .CalendarSingle:
            CalendarSingleView()
                .environmentObject(calendarSingleController)
        default:
            LoginView()
                .environmentObject(LoginViewModel(viewRouter: ViewRouter()))
        }
    }
}
