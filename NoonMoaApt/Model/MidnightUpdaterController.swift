//
//  MidnightUpdaterController.swift
//  NoonMoaApt
//
//  Created by kimpepe on 2023/07/25.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class MidnightUpdater: ObservableObject{
    private var firestoreManager: FirestoreManager {
        FirestoreManager.shared
    }
    private var db: Firestore {
        firestoreManager.db
    }
    func updateAllUsersToSleep() {
        print("updateAllUsersToSleep")
        firestoreManager.syncDB()
        db.collection("User").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("updateAllUsersToSleep in delegate")
                for document in querySnapshot!.documents {
                    self.db.collection("User").document(document.documentID).updateData([
                        "userState": "sleep"
                    ]) { err in
                        if let err = err {
                            print("Error updating user state: \(err)")
                        } else {
                            print("User state successfully updated to sleep")
                        }
                    }
                }
            }
        }
    }
}
