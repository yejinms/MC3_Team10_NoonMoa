//
//  DayView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/17.
//

import SwiftUI

struct DayView: View {
    let dayIndex: Int
    let weekIndex: Int
    @Binding var currentDate: Date

    var body: some View {
        let calendar = Calendar.current
        let date = calendar.date(bySetting: .weekOfMonth, value: weekIndex + 1, of: currentDate)!
            .advanced(by: TimeInterval(dayIndex * 24 * 60 * 60))
        let isCurrentMonth = calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
        let isSelectedDate = calendar.isDate(date, equalTo: currentDate, toGranularity: .day)

        Text(String(calendar.component(.day, from: date)))
            .font(isSelectedDate ? .headline : .body)
            .foregroundColor(isCurrentMonth ? .primary : .secondary)
            .frame(width: 30, height: 30)
            .background(isSelectedDate ? Color.blue : Color.clear)
            .cornerRadius(15)
            .onTapGesture {
                currentDate = date
            }
    }
}

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayView(dayIndex: <#T##Int#>, weekIndex: <#T##Int#>, currentDate: <#T##Binding<Date>#>)
//    }
//}
