//
//  File.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import Combine
import Foundation

class AIProfileDataFetcher: ObservableObject {
    @Published var aiProfiles: [AIProfile]?
    
    func fetchAIProfiles(){
        let fetchedAIProfiles = [
            AIProfile(id: "aiNo.1", nickname: "Alexis",profileImg: "ai_profile_me1", description: "like watching animation and go out for a walk.", language: "ENGLISH"),
            AIProfile(id: "aiNo.2", nickname: "Sandy",profileImg: "ai_profile_me2",description: "LUV U", language: "ENGLISH"),
            AIProfile(id: "aiNo.3", nickname: "Lily",profileImg: "ai_profile_me3",description: "HIHIHIHI", language: "ENGLISH"),
            AIProfile(id: "aiNo.4", nickname: "七星",profileImg: "ai_profile_me1",description: "因縁は 偶然に 尋ねて", language: "JAPANESE"),
            AIProfile(id: "aiNo.5", nickname: "フレーズ",profileImg: "ai_profile_me2",description: "時は 人を 待たず", language: "JAPANESE")
        ]
        self.aiProfiles = fetchedAIProfiles
    }
}
