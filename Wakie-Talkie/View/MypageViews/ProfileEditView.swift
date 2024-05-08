//
//  ProfileEditView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct ProfileEditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var islanguageSelected: [Bool] = [false,false,false,false,false]
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {dismiss()}, label: {
                    Text("<")
                        .fontWeight(.thin)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                })
                Spacer()
                Text("프로필 수정")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                Text("")
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
            }
            CustomCircleImg(imageUrl: "ai_profile_me1",showEditBtn: true, size: 150)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            HStack(){
                Text("닉네임")
                    .fontWeight(.medium)
                    .font(.system(size: 25))
                    .foregroundColor(Color("Black"))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                Text("밍밍망")
                    .fontWeight(.light)
                    .font(.system(size: 25))
                    .foregroundColor(Color("Black"))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                Spacer()
            }
            VStack(){
                HStack {
                    Text("배우고 싶은 언어")
                        .fontWeight(.medium)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Black"))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 10, trailing: 0))
                    Spacer()
                }
                HStack{
                    CustomLanguageButton(text: "영어", action: {
                        islanguageSelected[0] = !islanguageSelected[0]
                    }, isActive: $islanguageSelected[0])
                    CustomLanguageButton(text: "한국어", action: {
                        islanguageSelected[1] = !islanguageSelected[1]
                    }, isActive: $islanguageSelected[1])
                    CustomLanguageButton(text: "일본어", action: {
                        islanguageSelected[2] = !islanguageSelected[2]
                    }, isActive: $islanguageSelected[2])
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                HStack{
                    CustomLanguageButton(text: "프랑스어", action: {
                        islanguageSelected[3] = !islanguageSelected[3]
                    }, isActive: $islanguageSelected[3])
                    CustomLanguageButton(text: "어쩌구저어", action: {
                        islanguageSelected[4] = !islanguageSelected[4]
                    }, isActive: $islanguageSelected[4])
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 0))
            }
            Spacer()
            CustomButtonBig(text: "수정하기", action: {
                dismiss()
            }, color: Color("Black"), isActive: .constant(true))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileEditView()
}
