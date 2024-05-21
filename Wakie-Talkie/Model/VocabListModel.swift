//
//  VocabListModel.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import Foundation
struct VocabList: Identifiable, Codable, Equatable {
    var id: Int
    var userId: Int // 사용자 ID (FK)
    var recordingId: Int // 통화 date
    var date: String
    var wordList: [Vocab]// 단어
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case userId = "user_id"
        case recordingId = "recording_id"
        case wordList = "word_list"
    }
}

