//
//  AlarmViewModel.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import Combine
import Foundation

class AlarmDataFetcher: ObservableObject {
    @Published var alarms: [Alarm]?
    
    func fetchAlarms(){
        let fetchedAlarms = [
            Alarm(id: "alarm1", userId: "eunhwa813", time: transformToDate(dateString: "9:00 PM"), language: "ENGLISH", repeatDays: [false, false, false, false, false, false, false], isOn: true),
            Alarm(id: "alarm2", userId: "eunhwa813", time: transformToDate(dateString: "8:00 AM"), language: "KOREAN", repeatDays: [false, false, true, false, false, false, false], isOn: true),
            Alarm(id: "alarm3", userId: "eunhwa813", time: transformToDate(dateString: "12:00 PM"), language: "JAPANESE", repeatDays: [true, false, false, false, true, false, false], isOn: false),
            Alarm(id: "alarm4", userId: "eunhwa813", time: transformToDate(dateString: "7:00 PM"), language: "FRENCH", repeatDays: [false, true, false, false, false, false, false], isOn: true),
            Alarm(id: "alarm5", userId: "eunhwa813", time: transformToDate(dateString: "1:20 PM"), language: "CHINESE", repeatDays: [false, false, false, false, false, true, false], isOn: false)
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
