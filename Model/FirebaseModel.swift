//
//  RoomData.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var roomId: String?
    var aptId: String?
    var userState: String
    var lastActiveDate: Date?
    var eyeColor: String
    var attendanceSheetId: String? // Reference to AttendanceSheet document ID
    var token: String
    
    var stateEnum: UserState {
        get { return UserState(rawValue: userState) ?? .inactive }
        set { userState = newValue.rawValue }
    }
    
    var eyeColorEnum: EyeColor {
        get { return EyeColor(rawValue: eyeColor) ?? .blue }
        set { eyeColor = newValue.rawValue }
    }
}

struct AttendanceRecord: Codable, Identifiable {
    @DocumentID var id: String? // = UUID().uuidString <- 이 부분 제거
    var userId: String
    var date: Date
    var weatherCondition: String
    var eyeDirection: [Float]
    var aptId: String? // add this line
}


struct AttendanceSheet: Codable, Identifiable {
    @DocumentID var id: String?
    var attendanceRecords: [String] // References to AttendanceRecord document IDs
    var userId: String // Reference to User document ID
}

struct Room: Codable, Identifiable {
    @DocumentID var id: String?
    var aptId: String
    var number: Int
    var userId: String // References to User document IDs
    
    init(id: String?, aptId: String?, number: Int?, userId: String?) {
        self.id = id
        self.aptId = aptId ?? ""
        self.number = number ?? 0
        self.userId = userId ?? ""
    }
}

struct Apt: Codable, Identifiable {
    @DocumentID var id: String?
    var number: Int
    var rooms: [String] // References to Room document IDs
    var roomCount: Int // Total number of rooms
    
    init(id: String?, number: Int?, rooms: [String]?, roomCount: Int?) {
        self.id = id
        self.number = number ?? 0
        self.rooms = rooms ?? []
        self.roomCount = roomCount ?? 0
    }
}

struct Notification: Codable, Identifiable {
    @DocumentID var id: String? // Firestore에서 자동으로 생성하는 Document ID
    var receiverId: String // 알림을 받는 사용자의 ID
    var senderId: String // 알림을 보내는 사용자의 ID
    var type: String // 알림의 유형을 나타내는 문자열. 예를 들어 'request' 또는 'response'
    var sentAt: Date // 알림이 발송된 시간
    var read: Bool // 알림을 읽은 사용자의 ID

    // 이 enum은 Notification의 유형을 표현하고, Firebase와 호환성을 보장하기 위해 rawValue를 사용합니다.
    enum NotificationType: String {
        case request = "request"
        case response = "response"
    }

    var notificationTypeEnum: NotificationType {
        get { return NotificationType(rawValue: type) ?? .request }
        set { type = newValue.rawValue }
    }
}

enum UserState: String, Codable {
    case vacant = "vacant"
    case sleep = "sleep"
    case active = "active"
    case inactive = "inactive"
}

enum EyeColor: String, Codable {
    case pink = "pink"
    case cyan = "cyan"
    case yellow = "yellow"
    case blue = "blue"
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        switch label {
        case "pink":
            self = .pink
        case "cyan":
            self = .cyan
        case "yellow":
            self = .yellow
        case "blue":
            self = .blue
        // Add more cases as needed
        default:
            throw DecodingError.dataCorruptedError(in: try! decoder.singleValueContainer(), debugDescription: "Unable to decode eye color")
        }
    }
}

enum WeatherCondition: String, Codable {
    case clear = "clear"
    case cloudy = "cloudy"
    case rainy = "rainy"
    case snow = "snow"
    case thunderstorms = "thunderstorms"
}
