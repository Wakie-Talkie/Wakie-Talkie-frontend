//
//  RecordModel.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import Foundation

struct Recording: Identifiable, Codable, Equatable {
    var id: Int
    var userId: Int // 사용자 ID (FK)
    var aiPartnerId: Int
    var date: String // 통화 date
    var callingTime: String
    var convertedTextFile: String
    var recordedAudioFile: String
    var language: Int
    
    enum CodingKeys: String, CodingKey {
        case id, date, language
        case userId = "user_id"
        case aiPartnerId = "ai_partner_id"
        case callingTime = "calling_time"
        case convertedTextFile = "converted_text_file"
        case recordedAudioFile = "recorded_audio_file"
    }
    
    init(id: Int, userId: Int, aiPartnerId: Int, date: String, callingTime: String, convertedTextFile: String, recordedAudioFile: String, language: Int) {
        self.id = id
        self.userId = userId
        self.aiPartnerId = aiPartnerId
        self.date = date
        self.callingTime = callingTime
        self.convertedTextFile = convertedTextFile
        self.recordedAudioFile = recordedAudioFile
        self.language = language
    }
}

