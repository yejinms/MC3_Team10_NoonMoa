//
//  ViewRouter.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import Foundation
import SwiftUI

enum ViewState {
    case launchScreen
    case onBoarding
    case login
    case attendance
    case attendanceCompleted
    case apt
    case CalendarFull
    case CalendarSingle
}

class ViewRouter: ObservableObject {
    @Published var currentView: ViewState = .login
}
