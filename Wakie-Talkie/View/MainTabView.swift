//
//  MainTabView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CallView()
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("전화하기")
                }
            
            AlarmView()
                .tabItem {
                    Image(systemName: "alarm.fill")
                    Text("알람")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("마이페이지")
                }
        }
    }
}
