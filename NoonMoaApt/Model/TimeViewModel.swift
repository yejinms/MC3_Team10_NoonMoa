//
//  TimeViewModel.swift
//  MC3
//
//  Created by 최민규 on 2023/07/17.
//

import SwiftUI

class TimeViewModel: ObservableObject {
    
    //TODO: 현재 시간에 따라서 새벽, 아침, 오후, 저녁 케이스에 따라 이미지가 Day, Night가 될 수 있게 뿌려주고, 텍스트가 변경될 수 있게 뿌려준다.

    //테스트용으로 비활성화
//    @Published var currentTime = Calendar.current.component(.hour, from: Date())
//
//    var isDayTime: Bool {
//        return currentTime >= 6 && currentTime < 18
//    }
    
    //테스트용, 버튼으로 시간 바꾸기 위해 사용
    @Published var isDayTime: Bool = true
    
    
}
