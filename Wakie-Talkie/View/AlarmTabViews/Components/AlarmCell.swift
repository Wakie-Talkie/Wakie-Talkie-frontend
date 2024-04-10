//
//  AlarmCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import SwiftUI

struct AlarmCell: View {
    @State private var week: [String] = ["월", "화", "수", "목", "금","토","일"]
    @Binding var alarmData: Alarm
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Grey3").opacity(0.12))
                .frame(maxWidth: .infinity, maxHeight: 150)
            HStack{
                VStack(alignment: .leading,spacing: 5){
                    Text("언어: " + alarmData.language)
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        
                    Text(extractFormattedTime(from: alarmData.time))
                        .font(.system(size: 45))
                        .fontWeight(.light)
                    
                    HStack(alignment: .top, spacing: 5){
                        ForEach(0..<week.count, id: \.self) { index in
                            CustomButtonCircle(text: week[index], textSize: 12, isActive: $alarmData.repeatDays[index])
                                .disabled(true)
                        }
                        
                    }
                }
                Spacer()
                Toggle("", isOn: $alarmData.isOn)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color("Black")))
            }
            .padding()
        }
        .padding()
    }
    
    func extractFormattedTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
}


struct AlarmCellTestView: View{
    @State var alarm: Alarm = Alarm(id: "alarm1", userId: "eunhwa813", time: Date.now, language: "ENGLISH", repeatDays: [false, false, true, false, false, false, false], isOn: true)
    var body: some View{
        AlarmCell(alarmData: $alarm)
    }
}
#Preview {
    AlarmCellTestView()
}
