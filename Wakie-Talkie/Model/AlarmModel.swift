//
//  Alarm.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import Foundation

struct Alarm: Identifiable, Codable {
    var id: String
    var userId: String       // 사용자 ID (FK)
    var time: Date           // Date 타입으로 처리
    var language: String     // 알람 언어 (FK)
    var repeatDays: [String]? // 옵셔널 배열, ["M", "T", "W", "Th", "F", "S", "Su"]
    var isOn: Bool           // 알람이 켜져있는지 여부
    var aiProfiles: [String]? // 관련 AI 프로필의 ID 목록 (옵셔널 배열)
    
    init(id: String, userId: String, time: Date, language: String, repeatDays: [String]? = nil, isOn: Bool, aiProfiles: [String]? = nil) {
        self.id = id
        self.userId = userId
        self.time = time
        self.language = language
        self.repeatDays = repeatDays
        self.isOn = isOn
        self.aiProfiles = aiProfiles
    }
}

