//
//  FirestoreManager.swift
//  NoonMoaApt
//
//  Created by kimpepe on 2023/07/27.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    var db: Firestore
    
    private init() {
        self.db = Firestore.firestore()
    }
    
    // Firestore 데이터베이스 최신화 메서드
    func syncDB() {
        db = Firestore.firestore()
    }
}
