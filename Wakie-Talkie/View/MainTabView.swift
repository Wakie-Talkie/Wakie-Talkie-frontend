//
//  MainTabView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 2
    @State private var navigateToReceiveCall = false
    @StateObject var aiProfileData = AIProfileDataFetcher()
    @EnvironmentObject var alarmTimer: AlarmTimer

    var body: some View {
        NavigationStack {
            VStack {
                // 컨텐츠 영역
                switch selectedTab {
                case 1:
                    CallView()
                case 2:
                    AlarmView()
                default:
//                    ProfileView()
                    VocabView(changeTab: $selectedTab)
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
                            Image(systemName: selectedTab == 3 ? "text.book.closed.fill" : "text.book.closed")
                                .foregroundColor(.black)
                                .imageScale(.large)
                                .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                            Text("단어장")
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
            .onReceive(NotificationCenter.default.publisher(for: .init("TriggerReceiveCallView"))) { _ in
                aiProfileData.loadAiProilDataById(aiUserId:  alarmTimer.nextAlarmData?.aiProfileId ?? 1)
                if aiProfileData.aiProfile != nil {
                    navigateToReceiveCall = true
                }
            }
            .navigationDestination(isPresented: $navigateToReceiveCall) {
                ReceiveCallView(
                                navigateToReceiveCall: $navigateToReceiveCall,
                                postModel: UploadRecordingModel(userId: 1, aiPartnerId: alarmTimer.nextAlarmData?.aiProfileId ?? 1),
                                aiProfile:  aiProfileData.aiProfile ??
                                AIProfile(id: 1, nickname: "Alloy",profileImg: "profile", aiType: "openai", description: "how are you?", language: 1)
                )
            }
        }
    }
}

//#Preview {
//    MainTabView()
//}
