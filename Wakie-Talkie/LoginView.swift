//
//  LoginView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 2024/04/03.
//

import SwiftUI

struct LoginView: View {
    @State private var userId: String = ""
    @State private var userPassword: String = ""
    @State private var userInfo: String = ""
    var body: some View {
        ZStack {
            Color(hexString: "EEF5FA").ignoresSafeArea()
            VStack(spacing: 40){
                Image("app_title")
                VStack(spacing: -20){
                    TextField("id", text: $userId)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 350,height: 90)
                    TextField("password", text: $userPassword)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 350,height: 90)
                    HStack (spacing: 70) {
                        Button{
                            
                        } label: {
                            Text("회원가입")
                                .font(.system(size: 16, weight: .semibold))
                                .frame(minHeight: 52)
                                .cornerRadius(15)
                        }
                        .buttonStyle(.plain)
                        Button{
                            userInfo = "id: "+userId + " pw: " + userPassword
                        } label: {
                            Text("아이디 / 비밀번호 찾기")
                                .font(.system(size: 16, weight: .semibold))
                                .frame(minHeight: 52)
                                .cornerRadius(15)
                        }
                        .buttonStyle(.plain)
                    }
                    Text(userInfo)
                }
                Button{
                    
                } label: {
                    Text("로그인하기")
                        .padding(.horizontal,8)
                        .frame(minWidth: 350,maxHeight: 70)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(hexString: "08121B", opacity: 0.5))
                        .background((Color(hexString: "EDEFF1")))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
