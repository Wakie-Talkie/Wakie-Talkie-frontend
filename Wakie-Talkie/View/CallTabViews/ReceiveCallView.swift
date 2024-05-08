//
//  ReceiveCallView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/28/24.
//

import SwiftUI

struct ReceiveCallView: View {
    @Binding var navigateToReceiveCall: Bool
    @Environment(\.dismiss) var dismiss
    @State var aiProfile: AIProfile
    @State private var callReceived: Bool = false
    @EnvironmentObject var alarmTimer: AlarmTimer
    var alarmList: [AlarmTemp]
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Image("calling_background")
                            .edgesIgnoringSafeArea(.all)
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            VStack(spacing: 10){
                Text("전화 요청")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 80, trailing: 0))
                Image(aiProfile.profileImg ?? "ai_profile_img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Text(aiProfile.nickname)
                    .fontWeight(.medium)
                    .font(.system(size: 25))
                    .foregroundColor(Color("Black"))
                Text(aiProfile.description ?? "")
                    .fontWeight(.thin)
                    .font(.system(size: 20))
                    .foregroundColor(Color("Black"))
                    .frame(width:250, alignment: .center)
                Spacer()
                
                if callReceived{
                    CustomButtonBig(text: "전화 끊기", action: {dismiss()}, color: Color("Accent1"), isActive: .constant(true))
                }
                else{
                    Text("Speak " + aiProfile.language)
                        .fontWeight(.regular)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    CustomButtonBig(text: "전화 받기", action: {dismiss()
                        navigateToReceiveCall = false
                        alarmTimer.updateNextAlarmTime(time: (AlarmManager.findNextAlarmTime(alarms: alarmList) ) ?? Calendar.current.date(from: DateComponents(year: 2099, month: 1, day: 1))!) //TODO:empty array checking
                    }, color: Color("Black"), isActive: .constant(true))
                }
            }
        }.onAppear{
        }
    }
}
