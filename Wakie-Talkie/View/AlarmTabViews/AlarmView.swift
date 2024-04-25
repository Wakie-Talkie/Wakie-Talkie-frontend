//
//  AlarmView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct AlarmView: View {
    @State var alarms: [Alarm]
    @State private var isPresentingAddAlarm = false
    @State private var selectedAlarm: Alarm?
    var body: some View {
        NavigationStack {
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
                VStack(spacing: alarms.isEmpty ? 30 : 0) {
                    Text("전화 알람")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                    if alarms.isEmpty {
                        Spacer()
                        Text("아직 알람이 없어요!")
                            .font(.system(size: 25))
                            .fontWeight(.light)
                        CustomButtonBig(text: "알람 추가하기", action: {
                            isPresentingAddAlarm = true;
                        }, color: Color("Black"), isActive: .constant(true))
                        Spacer()
                    }
                    else{
                        ScrollView {
                            ForEach($alarms){ alarm in
                                NavigationLink(destination: ModifyAlarmView(alarmList: $alarms, alarmData: alarm)
                                ){
                                    AlarmCell(alarmData: alarm)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                }
                            }
                        }
                        CustomButtonBig(text: "알람 추가하기", action: {
                            isPresentingAddAlarm = true
                        }, color: Color("Black"), isActive: .constant(true))
                        .frame(alignment: .bottom)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                }
            }
            .navigationDestination(isPresented: $isPresentingAddAlarm){
                AddAlarmView(alarmList: $alarms)
            }
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
