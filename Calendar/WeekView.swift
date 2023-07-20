//
//  WeekView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/17.
//

import SwiftUI

struct WeekView: View {
    let weekIndex: Int
    @Binding var currentDate: Date

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<7) { dayIndex in
                DayView(dayIndex: dayIndex, weekIndex: weekIndex, currentDate: $currentDate)
            }
        }
    }
}

//struct WeekView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekView(weekIndex: <#T##Int#>, currentDate: <#T##Binding<Date>#>)
//    }
//}
