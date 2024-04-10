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
        VStack {
            // 컨텐츠 영역
            switch selectedTab {
            case 1:
                CallView()
            case 2:
                AlarmView(alarms: alarmDataFetcher.alarms ?? [])
            default:
                ProfileView()
            }
    
            HStack(alignment: .center){
                Button(action: {
                    self.selectedTab = 1
                }) {
                    VStack {
                        Spacer()
                        Image(systemName: selectedTab == 1 ? "phone.fill" : "phone")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        Text("전화하기")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    }
                        
                }
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
                
                Spacer()
                
                Button(action: {
                    self.selectedTab = 2
                }) {
                    VStack {
                        Spacer()
                        Image(systemName: selectedTab == 2 ? "alarm.fill" : "alarm")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        Text("전화알람")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.selectedTab = 3
                }) {
                    VStack {
                        Spacer()
                        Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        Text("마이페이지")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40))
            }
            .frame(height: 50, alignment: .bottom)
            .padding(EdgeInsets(top: 15, leading: 0, bottom: -10, trailing: 0))
            .background(Color("Main").opacity(0.7))
            
        }
        .onAppear {
            alarmDataFetcher.fetchAlarms()
        }
    }
}
//    }
//
//        
//        
//        TabView(selection: $selectedTab) {
//            CallView()
//                .tabItem {
//                    Image(systemName: "phone.fill")
//                    Text("전화하기")
//                }
//                .tag(1)
//            
//            AlarmView(alarms: alarmDataFetcher.alarms ?? [])
//                .tabItem {
//                    Image(systemName: "alarm.fill")
//                    Text("알람")
//                }
//                .tag(2)
//            ProfileView()
//                .tabItem {
//                    Image(systemName: "person.fill")
//                    Text("마이페이지")
//                }
//                .tag(3)
//        }
//        .onAppear {
//            alarmDataFetcher.fetchAlarms()
//        }
//        .background(Color("Black"))
//    }
//}

#Preview {
    MainTabView()
}
