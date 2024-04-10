//
//  ProfileView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("profileImage") // 프로필 이미지 자리
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 3)
                VStack(alignment: .leading) {
                    Text("민지민")
                        .font(.headline)
                    Text("배우고 싶은 언어: English")
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
            
            CustomButtonBig(text: "프로필 수정하기", action: {
                // 프로필 수정 로직
            }, color: Color("Black"), isActive: .constant(true))
            
            List {
                Text("동화 기록 보기")
                Text("AI 목소리 설정하기")
                Text("설정")
                Text("로그아웃")
            }
        }
        .navigationTitle("마이페이지")
        .navigationBarTitleDisplayMode(.inline)
    }
}
