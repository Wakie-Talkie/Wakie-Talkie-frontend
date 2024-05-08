//
//  AlarmView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct AlarmView: View {
    @FetchRequest(sortDescriptors: []) private var Alarms: FetchedResults<Alarm>
    @State var alarms: [AlarmDummy]
    @State private var isPresentingAddAlarm = false
    @State private var isPresentingMypage = false
    @State private var selectedAlarm: AlarmDummy?
    
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
                    HStack {
                        Text("")
                            .frame(width: 25, height: 25)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                        Spacer()
                        Text("전화 알람")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                        Spacer()
                        Button(action: {
                            isPresentingMypage = true
                        }){
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                    }
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
                            ForEach(Alarms, id: \.self) {alarm in
                                NavigationLink(destination: ModifyAlarmView(alarmList: AlarmDummy, alarmData: alarm)) {
                                    AlarmCell(alarmData: alarm).padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                }
                            }
//                            ForEach($alarms){ alarm in
//                                NavigationLink(destination: ModifyAlarmView(alarmList: $alarms, alarmData: alarm)
//                                ){
//                                    AlarmCell(alarmData: alarm)
//                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
//                                }
//                            }
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
            .navigationDestination(isPresented: $isPresentingMypage){
                ProfileView()
            }
        }
    }
}

struct AlarmTestView: View{
    @State var alarmDatas: [AlarmDummy] = [
        AlarmDummy(id: "alarm1", time: Date.now, language: "ENGLISH", repeatDays: [false, false, false, false, false, false, false], isOn: true),
        AlarmDummy(id: "alarm2", time: Date.now, language: "KOREAN", repeatDays: [false, false, true, false, false, false, false], isOn: true),
        AlarmDummy(id: "alarm3", time: Date.now, language: "JAPANESE", repeatDays: [true, false, false, false, true, false, false], isOn: false),
        AlarmDummy(id: "alarm4", time: Date.now, language: "FRENCH", repeatDays: [false, true, false, false, false, false, false], isOn: true),
        AlarmDummy(id: "alarm5", time: Date.now, language: "CHINESE", repeatDays: [false, false, false, false, false, true, false], isOn: false)
    ]

    var body: some View{
        AlarmView(alarms: alarmDatas)
    }
}


#Preview {
    AlarmTestView()
}
