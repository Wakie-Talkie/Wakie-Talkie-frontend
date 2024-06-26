//
//  User.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: Int            // 사용자 고유 ID
    var nickname: String      // 사용자 닉네임
    var profileImg: String?   // 프로필 이미지 URL (옵셔널)
    var description: String?  // 사용자 설명 (옵셔널)
    var language: Int      // 사용자의 모국어
    var wantLanguage: Int// 사용자가 배우고 싶어하는 언어 목록
    
    enum CodingKeys: String, CodingKey {
        case id, nickname, description, language
        case profileImg = "profile_img"
        case wantLanguage = "want_language"
    }
    
    // 커스텀 초기화 메소드 (옵셔널 필드를 처리하기 위해)
    init(id: Int, nickname: String, profileImg: String? = nil, description: String? = nil, language: Int, wantLanguage: Int) {
        self.id = id
        self.nickname = nickname
        self.profileImg = profileImg
        self.description = description
        self.language = language
        self.wantLanguage = wantLanguage
    }
}
