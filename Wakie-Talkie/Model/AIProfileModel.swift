//
//  AIPriofile.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import Foundation

struct AIProfile: Identifiable, Codable, Equatable {
    var id: Int
    var nickname: String
    var profileImg: String?   // 옵셔널로 처리
    var description: String?
    var language: Int      // 외래키(FK) 대신 연관된 언어의 ID나 이름을 저장
    
    enum CodingKeys: String, CodingKey {
        case id, nickname, description, language
        case profileImg = "profile_img"
    }
    
    init(id: Int, nickname: String, profileImg: String? = nil, description: String? = nil, language: Int) {
        self.id = id
        self.nickname = nickname
        self.profileImg = profileImg
        self.description = description
        self.language = language
    }
}
