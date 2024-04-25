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
            AIProfile(id: "aiNo.1", nickname: "Alexis",profileImg: "AIProfileImg", description: "like watching animation and go out for a walk.", language: "ENGLISH"),
            AIProfile(id: "aiNo.2", nickname: "Sandy",profileImg: "AIProfileImg",description: "FUCK YOU", language: "ENGLISH"),
            AIProfile(id: "aiNo.3", nickname: "Lily",profileImg: "AIProfileImg",description: "SHUT UP ㅗ", language: "ENGLISH")
        ]
        self.aiProfiles = fetchedAIProfiles
    }
}
