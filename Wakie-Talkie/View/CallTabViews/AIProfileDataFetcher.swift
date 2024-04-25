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
    
    func fetchAlarms(){
        let fetchedAlarms = [
            
        ]
        self.alarms = fetchedAlarms
    }
    
    func transformToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}
