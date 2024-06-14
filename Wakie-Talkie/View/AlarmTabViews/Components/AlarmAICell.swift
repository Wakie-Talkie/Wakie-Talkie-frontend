//
//  AlarmAICell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/22/24.
//

import SwiftUI

struct AlarmAICell: View {
    var aiProfile: AIProfile
    var action: () -> Void
    @Binding var isActive: Bool
    var body: some View{
        HStack(spacing: 15){
            CustomCircleImg(imageUrl: aiProfile.profileImg ?? "ai_profile_me1", size: 70, action:{})
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            VStack(alignment: .leading){
                Text(aiProfile.nickname)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
                    .foregroundColor(Color("Black"))
                Text(aiProfile.description ?? "")
                    .fontWeight(.light)
                    .font(.system(size: 16))
                    .foregroundColor(Color("Black"))
                    .frame(alignment: .leading)
                    .lineLimit(2)
            }
            Spacer()
            CustomButtonSmall(text: isActive ? "선택됨" : "선택", action: action, isActive: $isActive)
        }
        .frame(minWidth: 300,minHeight: 100)
        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
    }
}

