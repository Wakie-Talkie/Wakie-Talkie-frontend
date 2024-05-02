//
//  LoginView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//
import SwiftUI
import Authenticator

enum Destination {
    case onboarding
    case mainTab
}

struct LoginView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var selectedDestination: Destination?
    //@State private var navigationPath = NavigationPath()
    //@State private var isLoggedIn: Bool = false
    @State private var isFirstLogin: Bool = true
    @ObservedObject var state: SignInState
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Wakie Talkie")
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                CustomTextField(placeholder: "id", text: $state.username)
                CustomTextField(placeholder: "password", text: $state.password) //TODO: password blur처리
                Button("로그인하기") {
                    Task {
                        try? await state.signIn()
                    }
                        if isFirstLogin {
                            selectedDestination = .onboarding
                        } else {
                            selectedDestination = .mainTab
                        }
                    
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .disabled(state.username.isEmpty || state.password.isEmpty )
                
                Button("아이디/비밀번호 찾기") {
                    // 비밀번호 찾기 로직
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .onboarding:
                    OnboardingView()
                case .mainTab:
                    MainTabView()
                }
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
