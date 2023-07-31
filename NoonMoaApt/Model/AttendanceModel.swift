//
//  AttendanceModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct AttendanceRecord: Codable, Identifiable {
    @DocumentID var id: String? // = UUID().uuidString <- 이 부분 제거
    var userId: String
    
    var rawIsSmiling: Bool
    var rawIsBlinkingLeft: Bool
    var rawIsBlinkingRight: Bool
    var rawLookAtPoint: [Float]
    var rawFaceOrientation: [Float]
    var rawCharacterColor: [Float]
    
    var rawWeather: String
    var rawTime: Date
    var rawtSunriseTime: Date
    var rawSunsetTime: Date
}


class AttendanceModel: ObservableObject {
    
    private var characterModel: CharacterModel
    private var environmentModel: EnvironmentModel
    var newAttendanceRecord: AttendanceRecord
    var attendanceRecords: [Date: AttendanceRecord]
    

    //출석도장 찍거나 설정창에서 바꿀 때
    func uploadAttendanceRecord() {
    environmentModel.getCurrentEnvironment()
    environmentModel.saveRawEnvironmentToAttendanceModel()
    characterModel.getCurrentCharacter()
    characterModel.saveRawCharacterToAttendanceModel()
    //마지막으로firebase에 Date를 key값으로 사용하여, userId를 포함한 newAttendanceRecord를 기록한다!!!
    }

    //앱켜질 때 다운로드
    func downloadAttendanceRecords(key: Date) {
    let attendanceRecords = fetchAttendanceRecords()
    environmentModel.fetchRecordedEnvironment(record: attendanceRecords[key])
    characterModel.fetchRecordedCharacter((record: attendanceRecords[key])
    }

    func fetchAttendanceRecords() -> [Date: AttendanceRecord] {
    //Firebase에서 [Date: AttendanceRecord] 타입의 배열을 가져온다.
    }
}
