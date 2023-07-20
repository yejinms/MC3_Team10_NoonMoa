//
//  CalendarSingleController.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/20.
//

import Foundation
import Firebase
import SwiftUICalendar

class CalendarSingleController: ObservableObject {
    @Published public var yearMonthDay: YearMonthDay
    @Published public var record: AttendanceRecord?  // Add this line
    public var calendarController: CalendarController
    private var viewModel: CalendarFullViewModel

    public init(_ yearMonthDay: YearMonthDay = .current, viewModel: CalendarFullViewModel, orientation: Orientation = .horizontal, isLocked: Bool = false) {
        self.yearMonthDay = yearMonthDay
        self.viewModel = viewModel
        self.record = viewModel.record(for: yearMonthDay.date!)  // Update record here

        self.calendarController = CalendarController(YearMonth(year: yearMonthDay.year, month: yearMonthDay.month), orientation: orientation, isLocked: isLocked)
    }

    public func setYearMonthDay(_ yearMonthDay: YearMonthDay) {
        self.yearMonthDay = yearMonthDay
        self.record = viewModel.record(for: yearMonthDay.date!)  // Update record here
        self.calendarController.setYearMonth(year: yearMonthDay.year, month: yearMonthDay.month)
    }
    
    public var monthShortString: String {
        let yearMonth = YearMonth(year: yearMonthDay.year, month: yearMonthDay.month)
        return yearMonth.monthShortString
    }
}
