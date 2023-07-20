//
//  MonthView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/17.
//

import SwiftUI

struct MonthView: View {
    @Binding var currentDate: Date  // add a @Binding property
    let daysInWeek = 7
    var dummyData: [String]

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(0..<numberOfWeeks(in: currentDate), id: \.self) { week in  // replace startDate with currentDate
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<daysInWeek, id: \.self) { day in
                        VStack {
                            Text("\(dayOfWeek(for: day, in: week, of: currentDate))")  // replace startDate with currentDate
                            Text(dummyData[day % dummyData.count])
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }

    // Helper functions to calculate number of weeks in a month and day of the week for a given day
    func numberOfWeeks(in date: Date) -> Int {
        // For simplicity, we assume that all months have 4 weeks.
        return 4
    }

    func dayOfWeek(for day: Int, in week: Int, of date: Date) -> Int {
        // For simplicity, we assume that the first day of the month is a Sunday (day 1).
        return 1 + day + week * daysInWeek
    }
}

//struct MonthView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthView(currentDate: <#T##Binding<Date>#>, dummyData: <#T##[String]#>)
//    }
//}
