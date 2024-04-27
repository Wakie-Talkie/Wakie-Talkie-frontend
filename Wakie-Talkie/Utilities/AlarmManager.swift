//
//  AlarmManager.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/26/24.
//

import Foundation
import UserNotifications

class AlarmManager {
    static let shared = AlarmManager()

    
    func scheduleNextAlarm(alarms: [Alarm]) {
//        print("scheduledFuncssss")
//        print(alarms)
//        print("----")
        guard let nextAlarm = findNextAlarm(alarms: alarms) else {
            print("No alarms to schedule")
            return
        }
//        print("Next alarm: \(nextAlarm)")
        scheduleAlarmNotifications(alarm: nextAlarm)
    }
    
    private func findNextAlarm(alarms: [Alarm]) -> Alarm? {
        let now = Date()
        var closestAlarm: Alarm?
        var minimumTimeInterval: TimeInterval = .greatestFiniteMagnitude
        
        for alarm in alarms.filter({ $0.isOn }) {
            guard let nextAlarmTime = getNextAlarmTime(for: alarm, from: now) else {
                continue
            }
            let timeInterval = nextAlarmTime.timeIntervalSince(now)
            if timeInterval < minimumTimeInterval {
                minimumTimeInterval = timeInterval
                closestAlarm = alarm
            }
        }
        return closestAlarm
    }
    
    private func getNextAlarmTime(for alarm: Alarm, from referenceDate: Date) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: alarm.time)

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
                let daysToAdd = (i - calendar.component(.weekday, from: referenceDate) + 8) % 7
                if alarm.repeatDays[(calendar.component(.weekday, from: referenceDate) + daysToAdd - 1) % 7] {
                    let nextDate = calendar.date(byAdding: .day, value: daysToAdd, to: calendar.startOfDay(for: referenceDate))
                    return calendar.date(byAdding: components, to: nextDate!)
                }
            }
        }
        return nil
    }

    
    private func scheduleAlarmNotifications(alarm: Alarm) {
        let notificationTimes: [TimeInterval] = [0, 5, 10]  // 0초, 5초, 10초 후
        for secondsToAdd in notificationTimes {
            scheduleNotification(alarm: alarm, date: getNextAlarmTime(for: alarm, from: Date())!, secondsToAdd: secondsToAdd)
        }
    }

    private func scheduleNotification(alarm: Alarm, date: Date, secondsToAdd: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm for \(alarm.language)"
        content.body = "Alarm set for \(alarm.language) at \(alarm.time.formatted())"
        content.sound = UNNotificationSound.default

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
                print("Scheduled notification for \(alarm.language) at \(dateComponents) plus \(secondsToAdd) seconds")
            }
        }
    }

}
