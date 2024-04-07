//
//  TabView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 2024/04/04.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection = 1
    var body: some View {
        TabView(selection:$selection){
            CallView()
                .tabItem {
                    Image(systemName: "phone")
                    Text("전화하기")
                }.tag(0)
            AlarmView()
                .tabItem {
                    Image(systemName: "alarm")
                    Text("알람")
                }.tag(1)
            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("마이페이지")
                }.tag(2)
                
        }
        .tint(.black)
        .background(Color(hexString: "EEF5FA"))
    }
}

#Preview {
    TabBarView()
}
