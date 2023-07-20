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
    
    var body: some View {
        VStack {
            Text("Hello, \(currentUser?.uid ?? "NoBody")")
            Text("Weather: \(attendanceViewModel.weatherCondition)")
            Text("Eye Direction: \(attendanceViewModel.eyeDirection.map{ String($0) }.joined(separator: ", "))")
            Image(systemName: "tree")
                .frame(width: 150, height: 150)
            
            Button("Complete Attendance") {
                attendanceViewModel.createAttendanceRecord()
                viewRouter.currentView = .attendanceCompleted
            }
            
        }
    }
}


struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        // chatGPT needed
        AttendanceView()
    }
}
