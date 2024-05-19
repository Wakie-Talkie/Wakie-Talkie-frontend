//
//  CallPopupView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import SwiftUI

struct CallPopupView: View {
    @State var aiProfile: AIProfile
    @State private var startCalling: Bool = false
    var body: some View {
        VStack(spacing: 10){
            Text("전화하기")
                .fontWeight(.bold)
                .font(.system(size: 25))
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
            Image(aiProfile.profileImg ?? "ai_profile_img")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            Text(aiProfile.nickname)
                .fontWeight(.medium)
                .font(.system(size: 20))
                .foregroundColor(Color("Black"))
            Text(aiProfile.description ?? "")
                .fontWeight(.light)
                .font(.system(size: 16))
                .foregroundColor(Color("Black"))
                .frame(width:250, alignment: .center)
            Spacer()
            Text("Speak " + String(aiProfile.language))
                .fontWeight(.light)
                .font(.system(size: 20))
                .foregroundColor(Color("Black"))
            CustomButtonBig(text: "이 친구에게 전화하기", action: {
                self.startCalling = true
                
            }, color: Color("Black"), isActive: .constant(true))
        }
        .fullScreenCover(isPresented: $startCalling){
            SendCallView(aiProfile: aiProfile)
        }
    }
}

struct CallPopupTestView: View{
    @State var aipofileData: AIProfile =
        AIProfile(id: 1, nickname: "Alexis",profileImg: "ai_profile_img", description: "like watching animation and go out for a walk.", language: 1)
    var body: some View{
        CallPopupView(aiProfile: aipofileData)
    }
}

#Preview {
    CallPopupTestView()
}
