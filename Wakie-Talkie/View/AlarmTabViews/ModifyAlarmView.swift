//
//  AlarmModifyView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import SwiftUI

struct ModifyAlarmView: View {
    @Environment(\.dismiss) var dismiss
    @State private var week: [String] = ["월", "화", "수", "목", "금","토","일"]
    @State private var languages: [String] = ["영어", "한국어", "중국어", "일본어"]
    @State private var translatedLanguages: [String] = ["ENGLISH", "KOREAN", "CHINESE", "JAPANESE"]
    @State private var time: Date = Date()
    @State private var isAmActive: Bool = false
    @State private var isPmActive: Bool = false
    @State private var isLanguageSelected: [Bool] = [false, false, false, false]
    @State private var alarmTime: String = "12:00"
    
    @Binding var alarmList: [Alarm]
    @Binding var alarmData: Alarm
    var body: some View {
        VStack() {
            ScrollView {
                ZStack {
                    VStack(alignment: .leading){
                        //Section: 알람 시간
                        Text("알람 시간")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        HStack{
                            CustomButtonSmall(text: "오전", action: {
                                self.isAmActive = true
                                self.isPmActive = false
                            }, isActive: $isAmActive)
                            CustomButtonSmall(text: "오후", action: {
                                self.isAmActive = false
                                self.isPmActive = true
                            }, isActive: $isPmActive)
                            Text(alarmTime)
                                .font(.system(size: 25))
                                .fontWeight(.light)
                            Spacer()
                        }.padding(EdgeInsets(top: 5, leading: 0, bottom: 60, trailing: 0))
                        
                        //Section: 반복 주기
                        Text("반복 주기")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        HStack(alignment: .top, spacing: 13){
                            ForEach(0..<week.count, id: \.self) { index in
                                CustomButtonCircle(text: week[index], textSize: 15, padding: 10, isActive: $alarmData.repeatDays[index])
                            }
                        }
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 60, trailing: 30))
                        
                        //Section: 언어
                        HStack(alignment: .bottom){
                            Text("언어")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                            Spacer()
                            Text("*언어는 마이페이지에서 바꿀 수 있습니다")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                        }
                        
                        HStack{
                            ForEach(0..<languages.count, id: \.self) { index in
                                CustomButtonSmall(text: languages[index], action: {
                                    for i in 0..<isLanguageSelected.count {
                                        if i != index {
                                            isLanguageSelected[i] = false
                                        }else{
                                            isLanguageSelected[i] = true
                                            alarmData.language = translatedLanguages[i]
                                        }
                                    }
                                }, isActive: $isLanguageSelected[index])
                            }
                        }.padding(EdgeInsets(top: 5, leading: 0, bottom: 60, trailing: 0))
                        
                        //Section: 대화할 친구
                        Text("대화할 친구")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        HStack(alignment: .top, spacing: 13){
                            
                        }
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 60, trailing: 30))
                        
                    }.padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 0))
                }
            }
            CustomButtonBig(text: "알람 수정하기", action: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                time = dateFormatter.date(from: alarmTime + (isAmActive ? " AM":" PM")) ?? Date()
                alarmData.time = time
                dismiss()
            }, color: Color("Black"), isActive: .constant(true))
            .frame(alignment: .bottom)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            CustomButtonBig(text: "알람 삭제하기", action: {
                alarmList.removeAll{$0.id == alarmData.id}
                dismiss()
            }, color: Color("Accent1"), isActive: .constant(true))
            .frame(alignment: .bottom)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .onAppear {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "a"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            if dateFormatter.string(from: alarmData.time) == "AM"{
                isAmActive = true
            }else{
                isPmActive = true
            }
            dateFormatter.dateFormat = "h:mm"
            alarmTime = dateFormatter.string(from: alarmData.time)
                
            for i in 0..<isLanguageSelected.count {
                if translatedLanguages[i] != alarmData.language {
                    isLanguageSelected[i] = false
                }else{
                    isLanguageSelected[i] = true
                }
            }
        }
        .navigationTitle(Text("알람")
            .fontWeight(.bold)
            .font(.system(size: 25))
        )// 네비게이션 바 중앙의 제목
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("취소") {
                    dismiss() // 현재 뷰 닫기
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
struct ModifyAlarmTestView: View{
    @State var alarmDatas: [Alarm] = [
        Alarm(id: "alarm1", userId: "eunhwa813", time: Date.now, language: "ENGLISH", repeatDays: [false, false, false, false, false, false, false], isOn: true),
        Alarm(id: "alarm2", userId: "eunhwa813", time: Date.now, language: "KOREAN", repeatDays: [false, false, true, false, false, false, false], isOn: true),
        Alarm(id: "alarm3", userId: "eunhwa813", time: Date.now, language: "JAPANESE", repeatDays: [true, false, false, false, true, false, false], isOn: false),
        Alarm(id: "alarm4", userId: "eunhwa813", time: Date.now, language: "FRENCH", repeatDays: [false, true, false, false, false, false, false], isOn: true),
        Alarm(id: "alarm5", userId: "eunhwa813", time: Date.now, language: "CHINESE", repeatDays: [false, false, false, false, false, true, false], isOn: false)
    ]
    var body: some View{
        ModifyAlarmView(alarmList: $alarmDatas, alarmData: $alarmDatas[2])
    }
}
#Preview {
    ModifyAlarmTestView()
}