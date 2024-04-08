//
//  LoginView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct LoginView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var isFirstLogin: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Wakie Talkie")
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                CustomTextField(placeholder: "id", text: $id)
                CustomTextField(placeholder: "password", text: $password)
                NavigationLink(destination: isFirstLogin ? OnboardingView() : MainTabView(), isActive: $isLoggedIn) {
                    CustomButtonBig(text: "로그인하기", action: {
                        self.isLoggedIn = true
                    }, isActive: .constant(!(id.isEmpty || password.isEmpty)))
                }
                Button("아이디/비밀번호 찾기") {
                    // 비밀번호 찾기 로직
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}
