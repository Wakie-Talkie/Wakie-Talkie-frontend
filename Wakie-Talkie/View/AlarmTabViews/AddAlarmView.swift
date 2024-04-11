//
//  AddAlarmView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import SwiftUI

struct AddAlarmView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var alarmList: [Alarm]
    
    @State private var week: [String] = ["월", "화", "수", "목", "금","토","일"]
    @State private var languages: [String] = ["영어", "한국어", "중국어", "일본어"]
    @State private var translatedLanguages: [String] = ["ENGLISH", "KOREAN", "CHINESE", "JAPANESE"]
    @State private var addAlarmData: Alarm = Alarm()
    @State private var isAmActive: Bool = false
    @State private var isPmActive: Bool = false
    @State private var isLanguageSelected: [Bool] = [false, false, false, false]
    @State private var time: Date = Date()
    @State private var alarmTime: String = "12:00"
    @State private var language: String = ""
    @State private var repeatDays: [Bool] = [false, false, false, false, false, false, false]
    @State private var userId: String = "eunhwa813"
    
    var body: some View {
        VStack() {
//            HStack{
//                Spacer()
//                Text("알람 추가하기")
//                    .fontWeight(.bold)
//                    .font(.system(size: 25))
//                Button
//            }
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
                                CustomButtonCircle(text: week[index], textSize: 15, padding: 10, isActive: $repeatDays[index])
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
                                            language = translatedLanguages[i]
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
            CustomButtonBig(text: "알람 추가하기", action: {
                if((isAmActive || isPmActive) && !(language.isEmpty)){
                    addAlarmData.id = "alarm7"
                    addAlarmData.userId = "eunhwa813"
                    addAlarmData.isOn = true
                    addAlarmData.language = language
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    
                    time = dateFormatter.date(from: alarmTime + (isAmActive ? " AM":" PM")) ?? Date()
                    addAlarmData.time = time
                    addAlarmData.repeatDays = repeatDays
                    
                    alarmList.append(addAlarmData)
                    dismiss()
                }
            }, color: Color("Black"), isActive: .constant(true))
            .frame(alignment: .bottom)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .navigationTitle(Text("알람 추가하기")
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