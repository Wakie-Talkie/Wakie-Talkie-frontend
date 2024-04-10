//
//  MypageView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/10/24.
//

import SwiftUI

struct MypageView: View {
    @State private var isActive = true // 버튼 활성화 상태를 위한 State

    var body: some View {
        NavigationView {
            VStack {
                // 프로필 상단 부분
                ProfileHeaderView(name: "민민아", language: "배우고 싶은 언어: English")

                // '프로필 수정하기' 버튼
                CustomButtonMid(text: "프로필 수정하기", action: {
                    // 프로필 수정 액션
                }, isActive: $isActive)
                
                // 메뉴 항목들
                CustomMenuListView()
                
                Spacer()
            }
            .navigationBarTitle("마이페이지", displayMode: .inline)
        }
    }
}

struct ProfileHeaderView: View {
    let name: String
    let language: String

    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle") // 프로필 이미지를 나타내는 더미 이미지
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding()

            VStack(alignment: .leading, content: {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                
                
                Text(language)
                    .font(.subheadline)
                    .padding(.bottom)
            })
        }
    }
}

struct CustomMenuListView: View {
    var body: some View {
        // 커스텀 메뉴 리스트 뷰
        VStack(spacing: 20) {
            ForEach(MenuOption.allCases, id: \.self) { option in
                NavigationLink(destination: Text(option.title)) {
                    MenuRow(title: option.title)
                }
            }
        }
        .padding()
    }
}

struct MenuRow: View {
    var title: String
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .foregroundColor(.black)
    }
}

enum MenuOption: String, CaseIterable {
    case call = "통화 기록 보기"
    case voice = "AI 목소리 설정하기"
    case settings = "설정"
    case logout = "로그아웃"
    case contact = "문의하기"
    
    var title: String {
        self.rawValue
    }
}

// 여기에서 CustomButtonMid 구조체를 사용자가 제공한 대로 활용합니다.

// 프리뷰
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}
