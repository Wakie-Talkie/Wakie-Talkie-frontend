//
//  CallView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct CallView: View {
    @State var aiProfileList: [AIProfile]
    
    @State private var languages: [String] = ["영어", "한국어", "중국어", "일본어"]
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
                HStack{
                    Text("현재 언어: ")
                    ForEach(0..<languages.count, id: \.self) { index in
                        CustomButtonSmall(text: languages[index], action: {
                            for i in 0..<isLanguageSelected.count {
                                if i != index {
                                    isLanguageSelected[i] = false
                                }else{
                                    isLanguageSelected[i] = true
                                    //click한 언어 별로 알맞은 aiprofile들 띄워주는 funciton
                                }
                            }
                        }, isActive: $isLanguageSelected[index])
                    }
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 30, trailing: 0))
                
                //여기서 이제 언어 별 ai 띄우도록 거르는 function
                ScrollView {
                    ForEach($aiProfileList){ aiProfile in
                        NavigationLink(destination: ProfileView()//Modal Popup)
                        ){
                            AIProfileCell(aiData: aiProfile)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
struct CallTestView: View{
    @State var aipofileData: [AIProfile] = [
        AIProfile(id: "aiNo.1", nickname: "Alexis",profileImg: "AIProfileImg", description: "like watching animation and go out for a walk.", language: "ENGLISH"),
        AIProfile(id: "aiNo.2", nickname: "Sandy",profileImg: "AIProfileImg",description: "FUCK YOU", language: "ENGLISH"),
        AIProfile(id: "aiNo.3", nickname: "Lily",profileImg: "AIProfileImg",description: "SHUT UP ㅗ", language: "ENGLISH")
    ]
    var body: some View{
        CallView(aiProfileList: aipofileData)
    }
}

#Preview {
    CallTestView()
}
