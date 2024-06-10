//
//  MakeAIProfileView.swift
//  Wakie-Talkie
//
//  Created by jiin on 6/2/24.
//

import SwiftUI

struct MakeAIProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPresentingAIProfileEditView = false


    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer()
                        Image("alarm_background")
                            .edgesIgnoringSafeArea(.all)
                        
                    }
                }
            }
            VStack {
                HStack{
                    Button(action: {dismiss()}, label: {
                        Image("back_btn")
                    }) .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                    Spacer()
                    Text("목소리 추가")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                    Spacer()
                    Text("")
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
                }
                Spacer()
                Text("목소리 파일만으로\n내가 원하는 사람과\n매일매일 통화할 수 있어요")
                    .foregroundColor(Color("Black"))
                    .frame(alignment: .center)
                    .font(.system(size: 25))
                    .fontWeight(.regular)
                    .lineSpacing(10)
                    .multilineTextAlignment(.center)
                
                Spacer()
                Image("AddVoiceImages")
                Spacer()
                NavigationLink(
                    destination: MakeAIProfileEditView()){
                CustomButtonBig(text: "전화하러 가기", action: {
                    isPresentingAIProfileEditView = true
                }, color: Color("Black"), isActive: .constant(true))
            }
                .frame(alignment: .bottom)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isPresentingAIProfileEditView){
                MakeAIProfileEditView()
            }
    }
}


#Preview {
    MakeAIProfileView()
}
