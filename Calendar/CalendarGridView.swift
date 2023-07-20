//
//  CalendarGridView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/17.
//

import SwiftUI

struct CalendarGridView: View {
    @Binding var currentDate: Date

    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<numberOfWeeks(), id: \.self) { weekIndex in
                WeekView(weekIndex: weekIndex, currentDate: $currentDate)
            }
        }
        .padding()
    }

    private func numberOfWeeks() -> Int {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .weekOfMonth, in: .month, for: currentDate)
        return monthRange?.count ?? 0
    }
}

//struct CalendarGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarGridView(currentDate: <#T##Binding<Date>#>)
//    }
//}
