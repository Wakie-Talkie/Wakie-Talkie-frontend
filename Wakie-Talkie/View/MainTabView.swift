//
//  MainTabView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var alarmDataFetcher = AlarmDataFetcher()
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CallView()
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("전화하기")
                }
                .tag(1)
            
            AlarmView(alarms: alarmDataFetcher.alarms ?? [])
                .tabItem {
                    Image(systemName: "alarm.fill")
                    Text("알람")
                }
                .tag(2)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("마이페이지")
                }
                .tag(3)
        }
        .onAppear {
            alarmDataFetcher.fetchAlarms()
        }
    }
}

#Preview {
    MainTabView()
}
