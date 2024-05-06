//
//  VocabModel.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import Foundation
struct Vocab: Identifiable, Codable {
    var id: String
    var userId: String // 사용자 ID (FK)
    var time: Date // 통화 date
    var vocab: String// 단어
    var meaning: String// 단어 뜻
    
    init(id: String = "", userId: String = "", time: Date = Date(), vocab: String = "", meaning: String = "") {
        self.id = id
        self.userId = userId
        self.time = time
        self.vocab = vocab
        self.meaning = meaning
    }
}

