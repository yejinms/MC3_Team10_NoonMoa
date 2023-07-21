//
//  TimeViewModel.swift
//  MC3
//
//  Created by 최민규 on 2023/07/17.
//

import SwiftUI

class TimeViewModel: ObservableObject {
    
    //테스트용으로 비활성화
//    @Published var currentTime = Calendar.current.component(.hour, from: Date())
//
//    var isDayTime: Bool {
//        return currentTime >= 6 && currentTime < 18
//    }
    
    //테스트용, 버튼으로 시간 바꾸기 위해 사용
    @Published var isDayTime: Bool = true
    
    
}
