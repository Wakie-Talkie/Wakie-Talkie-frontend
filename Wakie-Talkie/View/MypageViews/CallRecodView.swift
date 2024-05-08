//
//  CallRecodView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct CallRecodView: View {
    @Environment(\.dismiss) var dismiss
    @State var recordList: [Record] = []
    @State private var lastDate:String = ""
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {dismiss()}, label: {
                    Text("<")
                        .fontWeight(.thin)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                })
                Spacer()
                Text("통화 기록")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                Text("")
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
            }
            ScrollView{
                ForEach(recordList.indices, id: \.self) { index in
                    let binding = $recordList[index]  // Creating a Binding<Record>
                    VStack{
                        if (index == 0)||((index != 0)&&(binding.date.wrappedValue != $recordList[index-1].date.wrappedValue)) {
                            Text(extractFormattedTime(from: binding.date.wrappedValue))
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                        }
                        CallRecordCell(recordData: binding)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
//    private func shouldUpdateDate(for recordDate: Date) -> Bool{
//        var isEqual: Bool = false
//        print("lastDate : " + self.lastDate)
//        print("binding : " + extractFormattedTime(from: recordDate))
//        if self.lastDate != extractFormattedTime(from: recordDate){
//            self.lastDate = extractFormattedTime(from: recordDate)
//        }else{
//            isEqual = true
//        }
//        return isEqual
//    }
    private func extractFormattedTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
}

struct CallRecordTestView: View{
    @State var recordDatas: [Record] = [
        Record(id: "record1",
               userId: "eunhwa813",
               aiProfile: AIProfile(id: "aiNo.1", nickname: "Alexis",profileImg: "ai_profile_me1", description: "like watching animation and go out for a walk.", language: "영어"),
               date: Date.now, recordedTime: "10:13"),
        Record(id: "record2",
               userId: "eunhwa813",
               aiProfile: AIProfile(id: "aiNo.2", nickname: "Sandy",profileImg: "ai_profile_me2",description: "LUV U", language: "영어"),
               date: Date.now, recordedTime: "12:3"),
        Record(id: "record3",
               userId: "eunhwa813",
               aiProfile: AIProfile(id: "aiNo.1", nickname: "Alexis",profileImg: "ai_profile_me1", description: "like watching animation and go out for a walk.", language: "영어"),
               date: Date.now, recordedTime: "10:13"),
        Record(id: "record4",
               userId: "eunhwa813",
               aiProfile: AIProfile(id: "aiNo.2", nickname: "Sandy",profileImg: "ai_profile_me2",description: "LUV U", language: "영어"),
               date: Date.now, recordedTime: "9:3")
    ]

    var body: some View{
        CallRecodView(recordList: recordDatas)
    }
}

#Preview {
    CallRecordTestView()
}
