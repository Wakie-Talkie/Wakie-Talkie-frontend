//
//  RecordDataFetcher.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import Combine
import Foundation

class RecordDataFetcher: ObservableObject {
    @Published var records: [Record]?
    
    func fetchRecords(){
        let fetchRecords = [
            Record(id: "record1",
                   userId: "eunhwa813",
                   aiProfile: AIProfile(id: 1, nickname: "Alexis",profileImg: "ai_profile_me1", description: "like watching animation and go out for a walk.", language: 1),
                   date: transformToDate(dateString: "2023 05 08"), recordedTime: "10:13"),
            Record(id: "record2",
                   userId: "eunhwa813",
                   aiProfile: AIProfile(id: 2, nickname: "Sandy",profileImg: "ai_profile_me2",description: "LUV U", language: 1),
                   date: transformToDate(dateString: "2023 05 08"), recordedTime: "12:3"),
            Record(id: "record3",
                   userId: "eunhwa813",
                   aiProfile: AIProfile(id: 1, nickname: "Alexis",profileImg: "ai_profile_me1", description: "like watching animation and go out for a walk.", language: 1),
                   date: transformToDate(dateString: "2023 05 05"), recordedTime: "10:13"),
            Record(id: "record4",
                   userId: "eunhwa813",
                   aiProfile: AIProfile(id: 2, nickname: "Sandy",profileImg: "ai_profile_me2",description: "LUV U", language: 1),
                   date: transformToDate(dateString: "2023 05 05"), recordedTime: "9:3"),
            Record(id: "record5",
                   userId: "eunhwa813",
                   aiProfile: AIProfile(id: 2, nickname: "Sandy",profileImg: "ai_profile_me1",description: "LUV U", language: 2),
                   date: transformToDate(dateString: "2023 05 10"), recordedTime: "9:3"),
            Record(id: "record6",
                   userId: "eunhwa813",
                   aiProfile: AIProfile(id: 1, nickname: "Sandy",profileImg: "ai_profile_me3",description: "LUV U", language: 2),
                   date: transformToDate(dateString: "2023 04 30"), recordedTime: "9:3")
        ]
        self.records = fetchRecords
    }
    
    private func transformToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}
