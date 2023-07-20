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
}
