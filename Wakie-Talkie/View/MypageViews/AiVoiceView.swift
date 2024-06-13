//
//  AiVoiceView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct AiVoiceView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var aiProfileData = AIProfileDataFetcher()
    @State private var isPresentingAIProfileView = false
    //private var aiVoiceList: [AIProfile] = []
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                HStack {
                    Button(action: {dismiss()}, label: {
                        Image("back_btn")
                    })
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                    Spacer()
                    Text("AI 목소리")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                    Spacer()
                    Text("")
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
                }
                ScrollView{
                    ForEach(aiProfileData.aiProfiles?.indices ?? [].indices, id: \.self){ index in
                        VStack{
                            if (index == 0)||((index != 0)&&(aiProfileData.aiProfiles![index].language != aiProfileData.aiProfiles![index-1].language)) {
                                HStack {
                                    Text(String(aiProfileData.aiProfiles![index].language))
                                        .fontWeight(.medium)
                                        .font(.system(size: 18))
                                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 0, trailing: 0))
                                    Spacer()
                                }
                            }
                            AiVoiceCell(aiProfile: aiProfileData.aiProfiles![index], action: {
                                //아직 어떻게 로직 짜야할지 모르겠음
                            }, isActive: .constant(true))
                        }
                    }
                    
                }
              //  NavigationLink(destination: MakeAIProfileView()) {
                    CustomButtonBig(text: "추가하기", action: {
                        self.isPresentingAIProfileView = true
                    }, color: Color("Black"), isActive: .constant(true))
                        .frame(alignment: .bottom)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
               // }
            }
            .onAppear{
                aiProfileData.loadAiProfileSortedData()
            }
            .navigationDestination(isPresented: $isPresentingAIProfileView){
                MakeAIProfileEditView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

//struct AiVoiceTestView: View{
//    @State var aipofileData: [AIProfile] = [
//        AIProfile(id: 1, nickname: "Alexis",profileImg: "ai_profile_me1", description: "like watching animation and go out for a walk.", language: 1),
//        AIProfile(id: 1, nickname: "Sandy",profileImg: "ai_profile_me2",description: "FUCK YOU", language: 1),
//        AIProfile(id: 3, nickname: "七星",profileImg: "ai_profile_me3",description: "因縁は 偶然に 尋ねて", language: 2),
//        AIProfile(id: 4, nickname: "フレーズ",profileImg: "ai_profile_me1",description: "時は 人を 待たず", language: 2)
//    ]
//    var body: some View{
//        AiVoiceView()
//    }
//}

//#Preview {
//    AiVoiceTestView()
//}
