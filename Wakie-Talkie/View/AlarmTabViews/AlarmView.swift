//
//  AlarmView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct AlarmView: View {
    @State var alarms: [Alarm]
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
            VStack(spacing: 30) {
                if alarms.isEmpty {
                    Spacer()
                    Text("아직 알람이 없어요!")
                        .font(.system(size: 25))
                        .fontWeight(.light)
                    CustomButtonBig(text: "알람 추가하기", action: {
                        // 알람 추가 로직
                    }, color: Color("Black"), isActive: .constant(true))
                    Spacer()
                }
                else{
                    ScrollView{
                        List {
                            ForEach($alarms){ alarm in
                                AlarmCell(alarmData: alarm)
                            }
                        }
                    }
                    CustomButtonBig(text: "알람 추가하기", action: {
                        // 알람 추가 로직
                    }, color: Color("Black"), isActive: .constant(true))
                    .frame(alignment: .bottom)
                }
            }
            .navigationTitle("알람")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlarmTestView: View{
    @State var alarmDatas: [Alarm] = [
        Alarm(id: "alarm1", userId: "eunhwa813", time: Date.now, language: "ENGLISH", repeatDays: [false, false, false, false, false, false, false], isOn: true),
        Alarm(id: "alarm2", userId: "eunhwa813", time: Date.now, language: "KOREAN", repeatDays: [false, false, true, false, false, false, false], isOn: true),
        Alarm(id: "alarm3", userId: "eunhwa813", time: Date.now, language: "JAPANESE", repeatDays: [true, false, false, false, true, false, false], isOn: false),
        Alarm(id: "alarm4", userId: "eunhwa813", time: Date.now, language: "FRENCH", repeatDays: [false, true, false, false, false, false, false], isOn: true),
        Alarm(id: "alarm5", userId: "eunhwa813", time: Date.now, language: "CHINESE", repeatDays: [false, false, false, false, false, true, false], isOn: false)
    ]
    var body: some View{
        AlarmView(alarms: alarmDatas)
    }
    
}


#Preview {
    AlarmTestView()
}
