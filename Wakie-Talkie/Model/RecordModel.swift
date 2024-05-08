//
//  RecordModel.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import Foundation

struct Record: Identifiable, Codable {
    var id: String
    var userId: String // 사용자 ID (FK)
    var aiProfile: AIProfile
    var date: Date // 통화 date
    var recordedTime: String
//    var voiceFile
//    var textFile
    
    init(id: String, userId: String, aiProfile: AIProfile, date: Date, recordedTime: String) {
        self.id = id
        self.userId = userId
        self.aiProfile = aiProfile
        self.date = date
        self.recordedTime = recordedTime
    }
}

