//
//  WakieTalkieApp.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import SwiftUI

@main
struct WakieTalkieApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var alarmTimer = AlarmTimer()
    
    var body: some Scene {
        WindowGroup{
            //LoginView()
            MainTabView()
                .environmentObject(alarmTimer)
        }
    }
}

