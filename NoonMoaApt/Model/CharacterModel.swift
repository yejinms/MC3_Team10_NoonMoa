//
//  CharacterModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import Foundation

class CharacterModel: ObservableObject {
    private var eyeViewController: EyeViewController
    private var customViewModel: CustomViewModel
    
    var rawIsSmiling: Bool
    var rawIsBlinkingLeft: Bool
    var rawIsBlinkingRight: Bool
    var rawLookAtPoint: [Float]
    var rawFaceOrientation: [Float]
    var rawCharacterColor: [Float]
    
    var currentIsSmiling: Bool
    var currentIsBlinkingLeft: Bool
    var currentIsBlinkingRight: Bool
    var currentLookAtPoint: SIMD3<Float>
    var currentFaceOrientation: SIMD3<Float>
    var currentCharacterColor: [Float]
    
    var recordedRawIsSmiling: Bool
    var recordedRawIsBlinkingLeft: Bool
    var recordedRawIsBlinkingRight: Bool
    var recordedRawLookAtPoint: [Float]
    var recordedRawFaceOrientation: [Float]
    var recordedRawCharacterColor: [Float]
    
    var recordedIsSmiling: Bool
    var recordedIsBlinkingLeft: Bool
    var recordedIsBlinkingRight: Bool
    var recordedLookAtPoint: SIMD3<Float>
    var recordedFaceOrientation: SIMD3<Float>
    var recordedCharacterColor: [Float]
    
    init(eyeViewController: EyeViewController, customViewModel: CustomViewModel, rawIsSmiling: Bool, rawIsBlinkingLeft: Bool, rawIsBlinkingRight: Bool, rawLookAtPoint: [Float], rawFaceOrientation: [Float], rawCharacterColor: [Float], currentIsSmiling: Bool, currentIsBlinkingLeft: Bool, currentIsBlinkingRight: Bool, currentLookAtPoint: SIMD3<Float>, currentFaceOrientation: SIMD3<Float>, currentCharacterColor: [Float], recordedRawIsSmiling: Bool, recordedRawIsBlinkingLeft: Bool, recordedRawIsBlinkingRight: Bool, recordedRawLookAtPoint: [Float], recordedRawFaceOrientation: [Float], recordedRawCharacterColor: [Float], recordedIsSmiling: Bool, recordedIsBlinkingLeft: Bool, recordedIsBlinkingRight: Bool, recordedLookAtPoint: SIMD3<Float>, recordedFaceOrientation: SIMD3<Float>, recordedCharacterColor: [Float]) {
        self.eyeViewController = eyeViewController
        self.customViewModel = customViewModel
        self.rawIsSmiling = rawIsSmiling
        self.rawIsBlinkingLeft = rawIsBlinkingLeft
        self.rawIsBlinkingRight = rawIsBlinkingRight
        self.rawLookAtPoint = rawLookAtPoint
        self.rawFaceOrientation = rawFaceOrientation
        self.rawCharacterColor = rawCharacterColor
        self.currentIsSmiling = currentIsSmiling
        self.currentIsBlinkingLeft = currentIsBlinkingLeft
        self.currentIsBlinkingRight = currentIsBlinkingRight
        self.currentLookAtPoint = currentLookAtPoint
        self.currentFaceOrientation = currentFaceOrientation
        self.currentCharacterColor = currentCharacterColor
        self.recordedRawIsSmiling = recordedRawIsSmiling
        self.recordedRawIsBlinkingLeft = recordedRawIsBlinkingLeft
        self.recordedRawIsBlinkingRight = recordedRawIsBlinkingRight
        self.recordedRawLookAtPoint = recordedRawLookAtPoint
        self.recordedRawFaceOrientation = recordedRawFaceOrientation
        self.recordedRawCharacterColor = recordedRawCharacterColor
        self.recordedIsSmiling = recordedIsSmiling
        self.recordedIsBlinkingLeft = recordedIsBlinkingLeft
        self.recordedIsBlinkingRight = recordedIsBlinkingRight
        self.recordedLookAtPoint = recordedLookAtPoint
        self.recordedFaceOrientation = recordedFaceOrientation
        self.recordedCharacterColor = recordedCharacterColor
    }
    
    func getCurrentCharacter() {
        currentIsSmiling = eyeViewController.eyeMyViewModel.isSmiling
        currentIsBlinkingLeft = eyeViewController.eyeMyViewModel.isBlinkingLeft
        currentIsBlinkingRight = eyeViewController.eyeMyViewModel.isBlinkingRight
        currentLookAtPoint = eyeViewController.eyeMyViewModel.lookAtPoint
        currentFaceOrientation = eyeViewController.eyeMyViewModel.faceOrientation
        currentCharacterColor = customViewModel.currentCharacterColor
    }
    
    //AttendanceModel을 통해 저장할 때 사용
    func convertViewDataToRawCharacter(isSmiling: Bool, isBlinkingLeft: Bool, isBlinkingRight: Bool, lookAtPoint: SIMD3<Float>, faceOrientation: SIMD3<Float>, characterColor: [Float]) {
        rawIsSmiling = isSmiling
        rawIsBlinkingLeft = isBlinkingLeft
        rawIsBlinkingRight = isBlinkingRight
        rawLookAtPoint = [Float(lookAtPoint.x), Float(lookAtPoint.y), Float(lookAtPoint.z)]
        rawFaceOrientation = [Float(faceOrientation.x), Float(faceOrientation.y), Float(faceOrientation.z)]
        rawCharacterColor = characterColor
    }
    
    func saveRawCharacter()  {
        //attendanceModel.newAttendanceRecord(...)
    }
    
    //AttendanceModel을 통해 받아올 때 사용한다.
    func fetchRecordedCharacter(record: AttendanceRecord) {
        saveRecordedRawCharacterToCharacterModel(record: record)
        convertRawCharacterToViewData(isSmiling: recordedRawIsSmiling, isBlinkingLeft: recordedRawIsBlinkingLeft, isBlinkingRight: recordedRawIsBlinkingRight, lookAtPoint: recordedRawLookAtPoint, faceOrientation: recordedRawFaceOrientation, characterColor: recordedRawCharacterColor)
    }
    
    func saveRecordedRawCharacterToCharacterModel(record: AttendanceRecord) {
        recordedRawIsSmiling = record.rawIsSmiling
        recordedRawIsBlinkingLeft = record.rawIsBlinkingLeft
        recordedRawIsBlinkingRight = record.rawIsBlinkingRight
        recordedRawLookAtPoint = record.rawLookAtPoint
        recordedRawFaceOrientation = record.rawFaceOrientation
        recordedRawCharacterColor = record.rawCharacterColor
    }
    
    func convertRawCharacterToViewData(isSmiling: Bool, isBlinkingLeft: Bool, isBlinkingRight: Bool, lookAtPoint: [Float], faceOrientation: [Float], characterColor: [Float] ) {
        recordedIsSmiling = isSmiling
        recordedIsBlinkingLeft = isBlinkingLeft
        recordedIsBlinkingRight = isBlinkingRight
        recordedLookAtPoint = SIMD3<Float>(lookAtPoint[0], lookAtPoint[1], lookAtPoint[2])
        recordedFaceOrientation = SIMD3<Float>(faceOrientation[0], faceOrientation[1], faceOrientation[2])
        recordedCharacterColor = characterColor
    }
    
    
}
