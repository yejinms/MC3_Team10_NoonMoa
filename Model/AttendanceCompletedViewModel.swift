//
//  AttendanceCompletedViewModel.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/20.
//

import Foundation
import Firebase

class AttendanceCompletedViewModel: ObservableObject {
    @Published var userId: String
    @Published var weatherCondition: String
    @Published var eyeDirection: [Float]
    @Published var attendanceRecord: AttendanceRecord? = nil
    @Published var user: User? = nil
    
    private var db = Firestore.firestore()
    
    init(record: AttendanceRecord) {
        self.userId = record.userId
        self.weatherCondition = record.weatherCondition
        self.eyeDirection = record.eyeDirection
        self.attendanceRecord = record
    }
    
    func saveAttendanceRecord() {
        let newRecord = AttendanceRecord(userId: userId, date: Date(), weatherCondition: weatherCondition, eyeDirection: eyeDirection)
        
        db.collection("User").document(userId).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                do {
                    let newRecordRef = try db.collection("AttendanceRecord").addDocument(from: newRecord)
                    self.attendanceRecord = newRecord
                    
                    // Create a new AttendanceSheet if it doesn't exist
                    let attendanceSheetRef = db.collection("AttendanceSheet").document(userId)
                    attendanceSheetRef.getDocument { [self] (document, error) in
                        if let document = document, document.exists {
                            // If the AttendanceSheet exists, update it
                            attendanceSheetRef.updateData([
                                "attendanceRecords": FieldValue.arrayUnion([newRecordRef.documentID])
                            ])
                        } else {
                            // If the AttendanceSheet doesn't exist, create a new one
                            let newAttendanceSheet = AttendanceSheet(id: self.userId, attendanceRecords: [newRecordRef.documentID], userId: userId)
                            do {
                                try attendanceSheetRef.setData(from: newAttendanceSheet)
                            } catch let error {
                                print("Error writing new attendance sheet to Firestore: \(error)")
                            }
                        }
                    }
                    
                } catch let error {
                    print("Error writing new attendance record to Firestore: \(error)")
                }
            } else {
                print("User does not exist!")
            }
        }
    }
    
    func updateUserLastActiveDate() {
        guard !userId.isEmpty else {
            print("Error: User ID is empty.")
            return
        }
        
        // Fetch the User document first
        db.collection("User").document(userId).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let user = try? document.data(as: User.self)
                
                // Now update the User document with lastActiveDate and state only
                self.db.collection("User").document(self.userId).setData([
                    "lastActiveDate": Date(),
                    "state": State.active.rawValue
                ], merge: true) { err in
                    if let err = err {
                        print("Error updating user: \(err)")
                    } else {
                        print("User updated")
                    }
                }
            }
        }
    }

}
