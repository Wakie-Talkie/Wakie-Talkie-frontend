//
//  UploadRecordingModel.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/18/24.
//

import Foundation
struct UploadRecordingModel: Codable, Equatable {
    var userId: Int
    var aiPartnerId: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case aiPartnerId = "ai_partner_id"
    }
    
    init(userId: Int, aiPartnerId: Int) {
        self.userId = userId
        self.aiPartnerId = aiPartnerId
    }
}
