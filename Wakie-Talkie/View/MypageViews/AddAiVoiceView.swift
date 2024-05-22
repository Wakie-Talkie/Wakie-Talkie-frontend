//
//  AddAiVoiceView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct AddAiVoiceView: View {
    @Environment(\.dismiss) var dismiss
    @State private var islanguageSelected: [Bool] = [false,false,false,false,false]
    @State private var aiDiscription: String = ""
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {dismiss()}, label: {
                    Image("back_btn")
                })
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                Spacer()
                Text("AI 추가하기")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                Text("")
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
            }
            CustomCircleImg(imageUrl: "ai_profile_me1",showEditBtn: true, size: 150)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            ScrollView{
                HStack(){
                    Text("AI 이름")
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
                        Text("AI가 사용할 언어")
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
                VStack{
                    HStack {
                        Text("AI 자기소개")
                            .fontWeight(.medium)
                            .font(.system(size: 25))
                            .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    HStack {
                        Text("비워두시면 자동으로 채워드릴게요.")
                            .fontWeight(.light)
                            .font(.system(size: 16))
                            .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    CustomTextField(placeholder: "성격, 취미 등... 자유롭게 적어주세요", text: $aiDiscription)
                    
                }
                
                VStack{
                    HStack {
                        Text("AI 목소리")
                            .fontWeight(.medium)
                            .font(.system(size: 25))
                            .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 0))
                        Spacer()
                        CustomButtonSmall(text: "파일 첨부하기", action: { }, isActive: .constant(true))
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 30))
                    }
                    HStack {
                        Text("첨부된 파일: MOV123.wav")
                            .fontWeight(.light)
                            .font(.system(size: 16))
                            .foregroundColor(Color("Black"))
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                        Spacer()
                    }
                }
                
            }
            
            CustomButtonBig(text: "수정하기", action: {
                //create customized_ai_profile
                dismiss()
            }, color: Color("Black"), isActive: .constant(true))
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddAiVoiceView()
}
