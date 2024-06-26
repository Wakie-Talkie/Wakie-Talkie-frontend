//
//  AlarmCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import SwiftUI
import SwiftData

struct AlarmCell: View {
    @State private var week: [String] = ["일", "월", "화", "수", "목", "금","토"]
    
    @Bindable var alarmData: Alarm
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Grey3").opacity(0.12))
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Main").opacity(0.3), lineWidth: 2)
                )
                
            HStack{
                VStack(alignment: .leading,spacing: 5){
                    Text("언어: " + alarmData.language)
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        
                    Text(extractFormattedTime(from: alarmData.time))
                        .font(.system(size: 45))
                        .fontWeight(.light)
                        .foregroundColor(Color("Black"))
                        .lineLimit(1)
                        .frame(minWidth: 200,alignment: .leading)
                    
                    HStack(alignment: .top, spacing: 8){
                        ForEach(0..<week.count, id: \.self) { index in
                            CustomButtonCircle(text: week[index], textSize: 12, padding: 7, isActive: $alarmData.repeatDays[index])
                                .disabled(true)
                        }
                    }
                }
                Spacer()
//                Toggle("", isOn: alarmData.isOn)
//                    .labelsHidden()
//                    .toggleStyle(SwitchToggleStyle(tint: Color("Black")))
            }
            .padding([.horizontal])
        }
        .padding([.horizontal])
    }
    
    func extractFormattedTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
}

