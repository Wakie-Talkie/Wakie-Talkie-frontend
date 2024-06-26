//
//  AlarmTimer.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/28/24.
//

import SwiftUI
import Combine

// App 상태 관리
class AlarmTimer: ObservableObject {
    @Published var nextAlarmTime: Date?
    @Published var nextAlarmData: Alarm?
    private var timer: AnyCancellable?

    init() {
        // 1초마다 시간을 체크
        print("!!!ALARM TIMER INIT!!!!!")
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            self?.checkTime()
        }
    }
    
    func updateNextAlarmTime(time: Date) {
        nextAlarmTime = time
        print("AlarmTimer :  \(String(describing: nextAlarmTime))")

    }
    
    func updateNextAlarmDate(alarm: Alarm?){
        nextAlarmData = alarm
        print("!!!!!!!!!!!!!!알람 업뎃!!!!!!!!!!")
    }
    
    func checkTime() {
        if let alarmTime = nextAlarmTime, Date() >= alarmTime {
            // ReceiveCallView로 이동하는 로직 실행
            NotificationCenter.default.post(name: .init("TriggerReceiveCallView"), object: nil)
        }
    }
}

