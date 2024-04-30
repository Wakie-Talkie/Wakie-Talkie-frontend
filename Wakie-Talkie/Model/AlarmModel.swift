//
//  Alarm.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import Foundation

struct Alarm: Identifiable, Codable {
    var id: String
    var userId: String    // 사용자 ID (FK)
    var time: Date // Date 타입으로 처리 -> transformToDate(dateString: "8:54 PM") 이런 형식으로 데이터가 들어옴
    var language: String// 알람 언어 (FK)
    var repeatDays: [Bool]// bool 배열, default = [false, false, false, false, false, false, false] -> 한번만 울리는 알람으로, time이 일치하는 최초의 시간에 한번 울리고 끝남
    var isOn: Bool      // 알람이 켜져있는지 여부
    var aiProfiles: [String]? // 관련 AI 프로필의 ID 목록 (옵셔널 배열)
    
    init(id: String = "", userId: String = "", time: Date = Date(), language: String = "", repeatDays: [Bool] = [false, false, false, false, false, false, false], isOn: Bool = true, aiProfiles: [String]? = nil) {
        self.id = id
        self.userId = userId
        self.time = time
        self.language = language
        self.repeatDays = repeatDays
        self.isOn = isOn
        self.aiProfiles = aiProfiles
    }
}

