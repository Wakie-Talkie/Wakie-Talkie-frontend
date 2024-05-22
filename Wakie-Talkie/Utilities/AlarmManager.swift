//
//  AlarmManager.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/26/24.
//

import Foundation
import UserNotifications
import SwiftData

class AlarmManager {
    static let shared = AlarmManager()
    
    
    static func scheduleNextAlarm(alarms: [Alarm]) {
        let center = UNUserNotificationCenter.current()
        
        // 이미 스케줄된 모든 알림을 제거
        center.removeAllPendingNotificationRequests()
        
        guard let nextAlarm = AlarmManager.findNextAlarm(alarms: alarms) else {
            print("No alarms to schedule")
            return
        }
        print("Next alarm : \(nextAlarm)")
        scheduleAlarmNotifications(alarm: nextAlarm)
    }
    
    static func findNextAlarmTime(alarms: [Alarm]) -> Date? {
        var closestAlarmTime: Date?
        
        return getNextAlarmTime(for: AlarmManager.findNextAlarm(alarms: alarms) ?? Alarm())
        
        //return closestAlarmTime
    }
    
    static func findNextAlarm(alarms: [Alarm]) -> Alarm? {
        var closestAlarm: Alarm?
        var minimumTimeInterval: TimeInterval = .greatestFiniteMagnitude
        
        for alarm in alarms.filter({ $0.isOn }) {
            guard let nextAlarmTime = AlarmManager.getNextAlarmTime(for: alarm) else {
                continue
            }
            let timeInterval = nextAlarmTime.timeIntervalSince(Date())
            print("NEXTALARMTIME:\(nextAlarmTime)")
            if timeInterval < minimumTimeInterval {
                minimumTimeInterval = timeInterval
                closestAlarm = alarm
                print("CLOSEST NOW: \(String(describing: closestAlarm))")
            }
        }
//        print("= = = = ")
//        print("closest alarm is: \(String(describing: closestAlarm))")
//        print("= = = = ")
        return closestAlarm
    }
    
    static func getNextAlarmTime(for alarm: Alarm) -> Date? {
        var calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: alarm.time)
        let referenceDate = Date()

        if alarm.repeatDays.allSatisfy({ !$0 }) {
            // 단발성 알람: 현재 시간이 알람 시간 이전이면 그대로 반환, 그렇지 않다면 다음날 반환
            let nextTime = calendar.date(byAdding: components, to: calendar.startOfDay(for: referenceDate))!
            if nextTime > referenceDate {
                return nextTime
            } else {
                // 다음날 같은 시간에 알람을 설정
                return calendar.date(byAdding: .day, value: 1, to: nextTime)
            }
        } else {
            // 반복 알람: 현재 요일로부터 다음 발생 요일을 찾음
            for i in 0..<7 {
                
                print("NOW: \(referenceDate)")
                let dayindex = i + calendar.component(.weekday, from: referenceDate) - 1//일월화수목금토
                if alarm.repeatDays[dayindex % 7] {
                    let daysToAdd = dayindex + 1 - calendar.component(.weekday, from: referenceDate)
                    print("DAYs to ADD: \(daysToAdd)")
                    var nextDate = calendar.date(byAdding: .day, value: daysToAdd, to: calendar.startOfDay(for: referenceDate))!
                    nextDate = calendar.date(byAdding: components, to: nextDate)!
                    print("ALARM: \(alarm.language) \(nextDate)")
                    if nextDate < referenceDate {
                        continue
                    }
                    return nextDate
                }
            }
        }
        return nil
    }

    
    static func scheduleAlarmNotifications(alarm: Alarm) {
        let notificationTimes: [TimeInterval] = Array(stride(from: 0, to: 5 * 120, by: 5))
        for secondsToAdd in notificationTimes {
            scheduleNotification(alarm: alarm, date: AlarmManager.getNextAlarmTime(for: alarm)!, secondsToAdd: secondsToAdd)
        }
    }

    static func scheduleNotification(alarm: Alarm, date: Date, secondsToAdd: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm for \(alarm.language)"
        content.body = "제 전화를 받아주세요!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "telephoneRing.wav"))

        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        if let second = dateComponents.second {
            dateComponents.second = second + Int(secondsToAdd)
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(alarm.id)-\(secondsToAdd)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
               // print("Scheduled notification for \(alarm.language) at \(dateComponents) plus \(secondsToAdd) seconds")
            }
        }
    }

}
