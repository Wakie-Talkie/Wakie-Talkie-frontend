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

    func scheduleAlarms(alarms: [Alarm]) {
        let center = UNUserNotificationCenter.current()

        // 이미 스케줄된 모든 알림을 제거
        center.removeAllPendingNotificationRequests()

        // 알람을 스케줄
        for alarm in alarms where alarm.isOn {
            scheduleAlarm(alarm: alarm)
        }
    }

    private func scheduleAlarm(alarm: Alarm) {
        let center = UNUserNotificationCenter.current()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
        
        print("함수 안임")
        print(dateComponents)
        print(alarm.repeatDays)
        
        if alarm.repeatDays.allSatisfy({ !$0 }) {
            // repeatDays가 모두 false일 경우, 단 한 번만 알람을 설정합니다.
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            createNotificationRequest(with: alarm, trigger: trigger)
        } else {
            // repeatDays가 하나 이상 true일 경우, 각 요일에 맞게 반복 알람을 설정합니다.
            let weekdays = alarm.repeatDays.enumerated().compactMap { $0.element ? $0.offset + 1 : nil }
            for weekday in weekdays {
                var components = dateComponents
                components.weekday = weekday
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                createNotificationRequest(with: alarm, trigger: trigger)
            }
        }
        print("------------")
    }

    private func createNotificationRequest(with alarm: Alarm, trigger: UNNotificationTrigger) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm!"
        content.body = "Time for your \(alarm.language) lesson!"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
        
        print("request is \(request)")

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    
    func checkIfShouldTriggerNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let currentComponents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: Date())
            for request in requests {
                if let trigger = request.trigger as? UNCalendarNotificationTrigger,
                   let triggerDate = trigger.nextTriggerDate(),
                   Calendar.current.isDate(triggerDate, equalTo: Date(), toGranularity: .minute) {
                    self.triggerLocalNotification(request: request)
                }
            }
        }
    }
    
    private func triggerLocalNotification(request: UNNotificationRequest) {
        // 여기에서 실제로 로컬 알림을 발동시키는 코드를 작성합니다.
        // 예를 들어 테스트 목적으로 콘솔에 출력을 하거나, 더 복잡한 동작을 수행할 수 있습니다.
        print("Triggering notification with id: \(request.identifier)")
        // TODO: 실제 앱에서는 여기에 UserNotifications 프레임워크를 사용하여 알림을 표시하는 코드를 작성합니다.
    }
}
