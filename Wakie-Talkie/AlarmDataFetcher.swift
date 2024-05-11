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
    
//    func fetchAlarms(){
//        let fetchedAlarms = [
//            AlarmTemp(id: "alarm1", userId: "eunhwa813", time: transformToDate(dateString: "8:34 PM"), language: "ENGLISH", repeatDays: [false, false, false, false, false, false, false], isOn: true),
//            AlarmTemp(id: "alarm2", userId: "eunhwa813", time: transformToDate(dateString: "8:00 AM"), language: "KOREAN", repeatDays: [false, true, false, true, false, false, false], isOn: true),
//            AlarmTemp(id: "alarm3", userId: "eunhwa813", time: transformToDate(dateString: "12:00 PM"), language: "JAPANESE", repeatDays: [false, true, false, false, false, true, false], isOn: false),
//            Alarm(id: "alarm4", userId: "eunhwa813", time: transformToDate(dateString: "7:00 PM"), language: "FRENCH", repeatDays: [false, false, true, false, false, false, false], isOn: true),
//            Alarm(id: "alarm5", userId: "eunhwa813", time: transformToDate(dateString: "1:20 PM"), language: "CHINESE", repeatDays: [false, false, false, false, false, false, true], isOn: false)
//        ]
//        self.alarms = fetchedAlarms
//
//        let a = AlarmManager()
//        a.scheduleNextAlarm(alarms: self.alarms ?? []) //TODO: 알람 생성, 수정시에도 이 함수 호출해야함.
//    }
    
    func transformToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}
