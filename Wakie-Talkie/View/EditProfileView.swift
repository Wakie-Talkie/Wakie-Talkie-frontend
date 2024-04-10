//
//  EditProfileView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/10/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var nickname: String = "민민아"
    @State private var selectedLanguage: String = "영어"
    // 언어 선택에 대한 옵션을 배열로 정의
    private let languageOptions = ["영어", "한국어", "일본어", "프랑스어", "이탈리아어"]
    @State private var isActive: Bool = true

    var body: some View {
        VStack {
            // 프로필 상단 "프로필 수정" 타이틀
            Text("프로필 수정")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            // 프로필 이미지
            Image("ProfileImage") // 이 부분에 실제 이미지 이름을 입력해주세요.
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()

            // 닉네임 필드
            HStack {
                Text("닉네임")
                    .font(.headline)
                    .foregroundColor(.secondary)
                TextField("닉네임을 입력해주세요", text: $nickname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            // 배우고 싶은 언어 선택
            HStack {
                Text("배우고 싶은 언어")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)

            // 언어 선택 버튼들
            LanguageSelectionGrid(selectedLanguage: $selectedLanguage, options: languageOptions)

            // 저장 버튼
//            Button("저장하기") {
//                // 여기에 저장 로직을 추가합니다.
//            }
//            .buttonStyle(CustomButtonStyle())
//            .padding()
            CustomButtonBig(text: "수정하기", action:{}, isActive: $isActive)

            Spacer()
        }
        .navigationTitle("프로필 수정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 언어 선택을 위한 그리드 뷰
struct LanguageSelectionGrid: View {
    @Binding var selectedLanguage: String
    var options: [String]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 15) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedLanguage = option
                }) {
                    Text(option)
                        .foregroundColor(selectedLanguage == option ? .white : .black)
                        .frame(width: 100, height: 50)
                        .background(selectedLanguage == option ? Color.black : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}


// 프리뷰 제공
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
