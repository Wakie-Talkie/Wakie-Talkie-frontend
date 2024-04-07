//
//  ContentView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 2024/04/03.
//

import SwiftUI

struct NicknameView: View {
    @State private var userNickname: String = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("join_background")
                    .position(CGPoint(x: 144.0, y: 262.0))
                    .ignoresSafeArea(.container, edges: .top)
                VStack {
                    Rectangle()
                        .frame(height: 200)
                        .background(Color.clear)
                        .foregroundStyle(.clear)
                    Text("안녕하세요!\n당신을 뭐라고 부르면 될까요?")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title)
                    //textfield가 잘림
                    TextField("닉네임을 알려주세요", text: $userNickname)
                        .padding()
                        .background(.white)
                        .border(Color(hexString: "EEF5FA"), width: 3)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 350,height: 90)
                        
                    Text(userNickname)
                        .fontWeight(.bold)
                    Rectangle()
                        .frame(height: 250)
                        .background(Color.clear)
                        .foregroundStyle(.clear)
                    NavigationLink(destination: LanguageView()){
                        Text("다음으로")
                            .fontWeight(.heavy)
                            .font(.title3)
                    }
                    .frame(width: 350, height: 30)
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hexString: "08121B"))
                    .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    NicknameView()
}

extension Color {
    init(hexString: String, opacity: Double = 1.0){
        let hex: Int = Int(hexString, radix: 16)!
        
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
