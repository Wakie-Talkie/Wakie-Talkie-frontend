//
//  AlarmView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI
import SwiftData


struct AlarmView: View {
   // @State var tempAlarms: [AlarmTemp]
    @State private var isPresentingAddAlarm = false
    @State private var isPresentingMypage = false
    @State private var selectedAlarm: AlarmTemp?
    
    @Query private var alarms: [Alarm]
    
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
                VStack(spacing: alarms.isEmpty ? 30 : 0) {//tempAlarms.isEmpty ? 30 : 0) {
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
                    if alarms.isEmpty{ //tempAlarms.isEmpty {
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
                            ForEach(alarms){ alarm in
                                NavigationLink(destination: ModifyAlarmView(alarmData: alarm)
                                ){
                                    AlarmCell(alarmData: alarm)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                }
                            }
//                            ForEach($tempAlarms){ alarm in
//                                NavigationLink(destination: ModifyAlarmView(alarmList: $tempAlarms, alarmData: alarm)
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
                AddAlarmView()
            }
            .navigationDestination(isPresented: $isPresentingMypage){
                ProfileView()
            }
        }
    }
}
