//
//  ProfileView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var isPresentingProfileEdit = false
    @State private var isPresentingRecodings = false
    @State private var isPresentingAiVoice = false
    @State private var isPresentingLogout = false
    @State private var recordDataFetcher = RecordDataFetcher()
//    @EnvironmentObject var aiProfileDataFetcher : AIProfileDataFetcher
    @State private var recordDatas:[Record] = []
    @State private var aiProfileDatas:[AIProfile] = []
    
    @ObservedObject var userData = UserDataFetcher()
//    @ObservedObject var aiProfileData = AIProfileDataFetcher()
    
    var body: some View {
        NavigationStack {
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            Image("alarm_background")
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        CustomCircleImg(imageUrl: userData.user?.profileImg, size: 90)
                            .padding()
                        VStack(alignment: .leading) {
                            if let nickname = userData.user?.nickname {
                                Text("\(nickname)")
                                    .font(.headline)
                            }
                            if let wantLanguage =  userData.user?.wantLanguage {
                                switch (wantLanguage) {
                                case 1:
                                    Text("배우고 싶은 언어: English")
                                        .font(.subheadline)
                                case 2:
                                    Text("배우고 싶은 언어: Korean")
                                        .font(.subheadline)
                                case 3:
                                    Text("배우고 싶은 언어: Japanese")
                                        .font(.subheadline)
                                case 4:
                                    Text("배우고 싶은 언어: Chinese")
                                        .font(.subheadline)
                                default:
                                    Text("배우고 싶은 언어: 없음")
                                        .font(.subheadline)
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    
                    CustomButtonBig(text: "프로필 수정하기", action: {
                        isPresentingProfileEdit = true
                    }, color: Color("Black"), isActive: .constant(true))
                    
                    List {
                        Text("통화 기록 보기")
                            .onTapGesture {
                                isPresentingRecodings = true
                            }
                        Text("AI 목소리 설정하기")
                            .onTapGesture {
                                isPresentingAiVoice = true
                            }
                        Text("설정")
                        Text("로그아웃")
                            .onTapGesture {
                                isPresentingLogout = true
                            }.alert(isPresented: $isPresentingLogout) {
                                Alert(
                                    title : Text("Wakie-Talkie에서 로그아웃하시겠어요?"),
                                    primaryButton : .default(Text("네"), action: {  }),
                                    secondaryButton : .cancel(Text("아니오"))
                                )
                            }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isPresentingProfileEdit){
                ProfileEditView()
            }
            .navigationDestination(isPresented: $isPresentingRecodings){
                CallRecodView(recordList: recordDatas)
            }
            .navigationDestination(isPresented: $isPresentingAiVoice){
                AiVoiceView()
            }
        }
        .onAppear(perform: {
            recordDataFetcher.fetchRecords()
            recordDatas = recordDataFetcher.records?.sorted{$0.date < $1.date} ?? []
            userData.loadUserData()
//            aiProfileData.loadAiProfileData()
//            aiProfileDataFetcher.getAIProfiles()
//            aiProfileDatas = aiProfileData.aiProfiles?.sorted{$0.language < $1.language} ?? []
        })
    }
}

//#Preview {
//    ProfileView()
//}
