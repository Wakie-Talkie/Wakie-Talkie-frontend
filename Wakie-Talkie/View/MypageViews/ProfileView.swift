//
//  ProfileView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPresentingProfileEdit = false
    @State private var isPresentingRecordings = false
    @State private var isPresentingAiVoice = false
    @State private var isPresentingLogout = false
//    @State private var recordDataFetcher = RecordDataFetcher()
//    @EnvironmentObject var aiProfileDataFetcher : AIProfileDataFetcher
//    @State private var recordDatas:[Record] = []
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
                        Button(action: {dismiss()}, label: {
                            Image("back_btn")
                        })
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                        Spacer()
                        Text("마이페이지")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                        Spacer()
                        Text("")
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
                    }
                    HStack {
                        CustomCircleImg(imageUrl: userData.user?.profileImg, size: 90, action: {})
                            .padding()
                        VStack(alignment: .leading) {
                            if let nickname = userData.user?.nickname {
                                Text("\(nickname)")
                                    .font(.system(size: 25))
                            }
                            if let wantLanguage =  userData.user?.wantLanguage {
                                switch (wantLanguage) {
                                case 1:
                                    Text("배우고 싶은 언어: English")
                                        .font(.subheadline)
                                        .font(.system(size:16))
                                        .fontWeight(.light)
                                case 2:
                                    Text("배우고 싶은 언어: Korean")
                                        .font(.subheadline)
                                        .font(.system(size:16))
                                        .fontWeight(.light)
                                case 3:
                                    Text("배우고 싶은 언어: Japanese")
                                        .font(.subheadline)
                                        .font(.system(size:16))
                                        .fontWeight(.light)
                                case 4:
                                    Text("배우고 싶은 언어: Chinese")
                                        .font(.subheadline)
                                        .font(.system(size:16))
                                        .fontWeight(.light)
                                default:
                                    Text("배우고 싶은 언어: 없음")
                                        .font(.subheadline)
                                        .font(.system(size:16))
                                        .fontWeight(.light)
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    
                    CustomButtonBig(text: "프로필 수정하기", action: {
                        isPresentingProfileEdit = true
                    }, color: Color("Black"), isActive: .constant(true))
                    
                //    List {
                    Button(action: {
                        isPresentingRecordings = true
                    }) {
                        Text("통화 기록 보기")
                            .font(.system(size:20))
                            .foregroundColor(.black)
                            .fontWeight(.light)
                    }.padding(EdgeInsets(top: 70, leading: 50, bottom: 27, trailing: 0))
                        
                    Button(action: {
                        isPresentingAiVoice = true
                    }) {
                        Text("AI 목소리 설정하기")
                            .font(.system(size:20))
                            .foregroundColor(.black)
                            .fontWeight(.light)
                    }.padding(EdgeInsets(top: 27, leading: 50, bottom: 27, trailing: 0))
                    Button(action: {
                    
                    }) {
                        Text("설정")
                            .font(.system(size:20))
                            .foregroundColor(.black)
                            .fontWeight(.light)
                    }.padding(EdgeInsets(top: 27, leading: 50, bottom: 27, trailing: 0))
                    
                
                   
                    Text("로그아웃")
                        .font(.system(size:20))
                        .fontWeight(.light)
                        .onTapGesture {
                            isPresentingLogout = true
                        }.alert(isPresented: $isPresentingLogout) {
                            Alert(
                                title : Text("Wakie-Talkie에서 로그아웃하시겠어요?"),
                                primaryButton : .default(Text("네"), action: {  }),
                                secondaryButton : .cancel(Text("아니오"))
                            )
                        }.padding(EdgeInsets(top: 27, leading: 50, bottom: 27, trailing: 0))
                    Spacer()
                  //  }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isPresentingProfileEdit){
                ProfileEditView()
            }
            .navigationDestination(isPresented: $isPresentingRecordings){
                CallRecodView()
            }
            .navigationDestination(isPresented: $isPresentingAiVoice){
                AiVoiceView()
            }
        }
        .onAppear(perform: {
            userData.loadUserData()
        })
    }
}
