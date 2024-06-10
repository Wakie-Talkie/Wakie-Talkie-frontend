//
//  AlarmView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI
import SwiftData


struct AlarmView: View {
    @State private var isPresentingAddAlarm = false
    @State private var isPresentingMypage = false
    @StateObject var aiProfileData = AIProfileDataFetcher()
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
                    if alarms.isEmpty{
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
                                NavigationLink(destination: ModifyAlarmView(alarmTime: transformDateToStr(date: alarm.time), alarmData: alarm)
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
                AddAlarmView(isAIProfileSelected: Array(repeating: false, count: (aiProfileData.aiProfiles ?? []).count), aiProfiles: aiProfileData.aiProfiles ?? [])
            }
            .navigationDestination(isPresented: $isPresentingMypage){
                ProfileView()
            }
            .onAppear{
                aiProfileData.loadAiProfileData()
                
            }
            .onChange(of: aiProfileData.aiProfiles){
                
            }
        }
    }
    
    func transformDateToStr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.string(from: date)
        return date
    }
}
