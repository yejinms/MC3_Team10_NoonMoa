////
////  DayCalendarView.swift
////  MangMongApt
////
////  Created by kimpepe on 2023/07/17.
////
//
//import SwiftUI
//import SwiftUICalendar
//
//public class CalendarDayController: ObservableObject {
//    @Published public var yearMonthDay: YearMonthDay
//    public var calendarController: CalendarController
//
//    public init(_ yearMonthDay: YearMonthDay = .current, orientation: Orientation = .horizontal, isLocked: Bool = false) {
//        self.yearMonthDay = yearMonthDay
//        self.calendarController = CalendarController(YearMonth(year: yearMonthDay.year, month: yearMonthDay.month), orientation: orientation, isLocked: isLocked)
//    }
//
//
//    public func setYearMonthDay(_ yearMonthDay: YearMonthDay) {
//        self.yearMonthDay = yearMonthDay
//        self.calendarController.setYearMonth(year: yearMonthDay.year, month: yearMonthDay.month)
//    }
//
//    public var monthShortString: String {
//        let yearMonth = YearMonth(year: yearMonthDay.year, month: yearMonthDay.month)
//        return yearMonth.monthShortString
//    }
//}
//
//struct CalendarDayView: View {
//    @ObservedObject var controller: CalendarDayController = CalendarDayController()
//
//    var body: some View {
//        GeometryReader { reader in
//            VStack {
//                HStack(alignment: .center, spacing: 0) {
//                    Button("Prev") {
//                        controller.setYearMonthDay(controller.yearMonthDay.addDay(value: -1))
//                    }
//                    .padding(8)
//                    Spacer()
//                    Text("\(controller.yearMonthDay.day), \(controller.monthShortString), \(String(controller.yearMonthDay.year))")
//                        .font(.title)
//                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
//                    Spacer()
//                    Button("Next") {
//                        controller.setYearMonthDay(controller.yearMonthDay.addDay(value: 1))
//                    }
//                    .padding(8)
//                }
//                // The rest of your code...
//            }
//        }
//        // The rest of your code...
//    }
//}
//
//struct DayCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarDayView()
//    }
//}
//
//
