//
//  CallView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct CallView: View {
//    @EnvironmentObject var aiDataFetcher: AIProfileDataFetcher
    @StateObject var aiProfileData = AIProfileDataFetcher()
    @State private var selection: AIProfile? = nil
    @State private var showModal: Bool = false
    
    @State private var languages: [String] = ["영어", "한국어", "일본어", "중국어"]
    @State private var isLanguageSelected: [Bool] = [false, false, false, false]
    var body: some View {
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
            VStack() {
                Text("전화하기")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                HStack{
                    Text("현재 언어: ")
                    ForEach(0..<languages.count, id: \.self) { index in
                        CustomButtonSmall(text: languages[index], action: {
                            for i in 0..<isLanguageSelected.count {
                                if i != index {
                                    isLanguageSelected[i] = false
                                }else{
                                    isLanguageSelected[i] = true
                                    if i > 1 {
                                        aiProfileData.loadAiProfileDataFromLang(language: i+2)
                                    }else {
                                        aiProfileData.loadAiProfileDataFromLang(language: i+1)
                                    }
                                }
                            }
                        }, isActive: $isLanguageSelected[index])
                    }
                    
                }.padding(EdgeInsets(top: 40, leading: 0, bottom: 30, trailing: 0))
//                CallPopupView(aiProfile: AIProfile(id:1, nickname: "bb", profileImg: nil, description: "aaa", language: 1))
                
                //여기서 이제 언어 별 ai 띄우도록 거르는 function
                ScrollView {
                    ForEach(aiProfileData.aiProfiles?.indices ?? [].indices, id: \.self){ index in
                        AIProfileCell(aiData: aiProfileData.aiProfiles![index])
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                .onTapGesture {
                                    self.showModal = true
                                    self.selection = aiProfileData.aiProfiles![index]
                                }
                    }
                }
                .sheet(isPresented: $showModal){
                    if let selectedItem = selection{
                        CallPopupView(aiProfile: selectedItem)
                            .presentationDetents([.fraction(0.7)])
                    }
                }
                Spacer()
            }
        }
        .onAppear{
//            aiDataFetcher.getAIProfiles()
            aiProfileData.loadAiProfileData()
        }
        .onChange(of: aiProfileData.aiProfiles){
//            print(aiProfileData.aiProfiles)
//            print("profile nickname!!!! : \(aiProfileData.aiProfiles?[0].nickname)")
        }
    }
}
struct CallTestView: View{
    var body: some View{
        CallView().environmentObject(AIProfileDataFetcher())
    }
}

//#Preview {
//    CallTestView()
//}
