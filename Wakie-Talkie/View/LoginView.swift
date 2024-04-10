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
    @State private var navigationPath = NavigationPath()
    //@State private var isLoggedIn: Bool = false
    @State private var isFirstLogin: Bool = true
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Wakie Talkie")
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                CustomTextField(placeholder: "id", text: $id)
                CustomTextField(placeholder: "password", text: $password)
                Button("로그인하기") {
                    if !(id.isEmpty || password.isEmpty) {
                        if isFirstLogin {
                            //navigationPath.append(OnboardingView.self)
                        } else {
                            navigationPath.append(MainTabView.self)
                        }
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .disabled(id.isEmpty || password.isEmpty)
                
                Button("아이디/비밀번호 찾기") {
                    // 비밀번호 찾기 로직
                }
                .padding(.top, 20)
            }
            .padding()
        }
//        .navigationDestination(for: OnboardingView.self) { _ in
//            OnboardingView()
//        }
        .navigationDestination(for: MainTabView.self) { _ in
            MainTabView()
        }
    }
}
