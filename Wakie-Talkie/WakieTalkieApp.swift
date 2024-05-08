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
    @StateObject private var manager: DataManager = DataManager() //Coredata
    
    var body: some Scene {
        WindowGroup{
            //LoginView()
            MainTabView()
                .environmentObject(alarmTimer)
                .environmentObject(manager) //Coredata
                .environment(\.managedObjectContext, manager.container.viewContext) //Coredata
        }
    }
}

