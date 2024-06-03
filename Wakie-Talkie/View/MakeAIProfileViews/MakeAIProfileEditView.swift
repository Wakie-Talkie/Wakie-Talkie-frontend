//
//  MakeAIProfileEditView.swift
//  Wakie-Talkie
//
//  Created by jiin on 6/3/24.
//

import SwiftUI


struct MakeAIProfileEditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var islanguageSelected: [Bool] = [false,false,false,false,false]
    @State private var inputText: String = ""
    @State private var isAmActive: Bool = true
    @State private var showDocumentPicker = false
    @State private var selectedFileURL: URL?
    
    var body: some View {
        ScrollView{            
            HStack{
                Button(action: {dismiss()}, label: {
                    Image("back_btn")
                }) .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                Spacer()
                Text("AI 추가")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                Text("")
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
            }
            CustomCircleImg(imageUrl: "profile", showEditBtn: true, size: 150)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            HStack(){
                Text("AI 이름")
                    .fontWeight(.medium)
                    .font(.system(size: 25))
                    .foregroundColor(Color("Black"))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                    Text("nickname")
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
                HStack {
                    Text("AI 자기소개")
                        .fontWeight(.medium)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Black"))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 5, trailing: 0))
                    Spacer()
                }
                HStack{
                    Text("비워두시면 자동으로 채워드릴게요")
                        .fontWeight(.light)
                        .font(.system(size: 16))
                        .foregroundColor(Color("Black"))
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                    Spacer()
                }
                CustomTextView(
                                text: $inputText,
                                placeholder: "성격, 취미 등... 자유롭게 적어주세요",
                                placeholderColor: UIColor.lightGray,
                                textColor: UIColor(Color("Grey3")),
                                borderColor: UIColor(Color("Grey3")),
                                height: 137
                            )
                            .frame(height: 137)
                            .padding()
                HStack{
                    Text("AI 목소리")
                        .fontWeight(.medium)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Black"))
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                    Spacer()
                    CustomButtonSmall(text: "파일 첨부하기", action: {
                        showDocumentPicker.toggle()
                    }, isActive: $isAmActive)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                }
                    CustomButtonBig(text: "추가하기", action: {
                        dismiss()
                    }, color: Color("Black"), isActive: .constant(true))
                    .frame(alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                
            }
        }
        .sheet(isPresented: $showDocumentPicker) {
                    DocumentPicker { url in
                        self.selectedFileURL = url
                    }
                }
    }
}

#Preview{
    MakeAIProfileEditView()
}
