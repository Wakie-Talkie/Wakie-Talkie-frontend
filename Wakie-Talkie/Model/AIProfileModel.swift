//
//  AIPriofile.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import Foundation

struct AIProfile: Identifiable, Codable {
    var id: String
    var nickname: String
    var profileImg: String?   // 옵셔널로 처리
    var description: String?
    var language: String      // 외래키(FK) 대신 연관된 언어의 ID나 이름을 저장
    
    init(id: String, nickname: String, profileImg: String? = nil, description: String? = nil, language: String) {
        self.id = id
        self.nickname = nickname
        self.profileImg = profileImg
        self.description = description
        self.language = language
    }
}
