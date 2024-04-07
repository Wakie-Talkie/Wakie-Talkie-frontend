//
//  LanguageView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 2024/04/03.
//

import SwiftUI

struct LanguageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var languageList:Array = ["영어","한국어","일본어","프랑스어","어쩌구저어"]
    @State private var isButtonClicked:Array = [false,false,false,false,false]
    //@State private var userNickname: String = ""
    
    var backButton : some View {  // <-- 👀 커스텀 버튼
           Button{
               self.presentationMode.wrappedValue.dismiss()
           } label: {
               HStack {
                   Image(systemName: "chevron.left") // 화살표 Image
                       .aspectRatio(contentMode: .fit)
                   Text("뒤뒤뒤")
               }
           }
       }
    
    var body: some View {
        ZStack {
            Image("join_background")
                .position(CGPoint(x: 144.0, y: 262.0))
                .ignoresSafeArea(.container, edges: .top)
            VStack {
                Rectangle()
                    .frame(height: 200)
                    .background(Color.clear)
                    .foregroundStyle(.clear)
                Text("배우고 싶은 언어를 골라주세요")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                //textfield가 잘림
                HStack(spacing: 10){
                    Button{
                        isButtonClicked[0] = !isButtonClicked[0]
                    } label: {
                        Text(languageList[0])
                            .foregroundColor(isButtonClicked[0] ? .white : Color(hexString: "08121B"))
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 100, minHeight: 52)
                            .background(isButtonClicked[0] ? Color(hexString: "05121B") : Color(hexString: "F4F5F7"))
                            .cornerRadius(15)
                    }
                    Button{
                        isButtonClicked[1] = !isButtonClicked[1]
                    } label: {
                        Text(languageList[1])
                            .foregroundColor(isButtonClicked[1] ? .white : Color(hexString: "08121B"))
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 100, minHeight: 52)
                            .background(isButtonClicked[1] ? Color(hexString: "05121B") : Color(hexString: "F4F5F7"))
                            .cornerRadius(15)
                    }
                    Button{
                        isButtonClicked[2] = !isButtonClicked[2]
                    } label: {
                        Text(languageList[2])
                            .foregroundColor(isButtonClicked[2] ? .white : Color(hexString: "08121B"))
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 100, minHeight: 52)
                            .background(isButtonClicked[2] ? Color(hexString: "05121B") : Color(hexString: "F4F5F7"))
                            .cornerRadius(15)
                    }
                }
                HStack(spacing: 10){
                    Button{
                        isButtonClicked[3] = !isButtonClicked[3]
                    } label: {
                        Text(languageList[3])
                            .foregroundColor(isButtonClicked[3] ? .white : Color(hexString: "08121B"))
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 100, minHeight: 52)
                            .background(isButtonClicked[3] ? Color(hexString: "05121B") : Color(hexString: "F4F5F7"))
                            .cornerRadius(15)
                    }
                    Button{
                        isButtonClicked[4] = !isButtonClicked[4]
                    } label: {
                        Text(languageList[4])
                            .foregroundColor(isButtonClicked[4] ? .white : Color(hexString: "08121B"))
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 100, minHeight: 52)
                            .background(isButtonClicked[4] ? Color(hexString: "05121B") : Color(hexString: "F4F5F7"))
                            .cornerRadius(15)
                    }
                }
                Rectangle()
                    .frame(height: 250)
                    .background(Color.clear)
                    .foregroundStyle(.clear)
                NavigationLink(destination: LoginView()){
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

#Preview {
    LanguageView()
}
