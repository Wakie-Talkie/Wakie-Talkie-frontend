//
//  CallRecordCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct CallRecordCell: View {
    @Binding var recordData: Record
    var body: some View{
        HStack(spacing: 15){
            CustomCircleImg(imageUrl: recordData.aiProfile.profileImg ?? "ai_profile_me1", size: 70)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            VStack(alignment: .leading){
                Text(recordData.aiProfile.nickname)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
                    .foregroundColor(Color("Black"))
                Text(String(recordData.aiProfile.language) + " - " + transTime(time: recordData.recordedTime))
                    .fontWeight(.light)
                    .font(.system(size: 16))
                    .foregroundColor(Color("Black"))
                    .frame(alignment: .leading)
            }
            Spacer()
            CustomButtonSmall(text: "기록보기", action: {
                //기록 페이지로 넘어가게 하기
            }, isActive: .constant(true))
        }
        .frame(minWidth: 300,minHeight: 100)
        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
    }
    func transTime(time: String)-> String{
        var arr = time.components(separatedBy: ":")
        return arr[0]+"분 "+arr[1]+"초"
    }
}
struct CallRecordCellTestView: View{
    @State var record: Record = Record(id: "record1",
                                 userId: "eunhwa813",
                                 aiProfile: AIProfile(id: 1, nickname: "Alexis",profileImg: "ai_profile_me1", description: "like watching animation and go out for a walk.", language: 1),
                                       date: Date.now, recordedTime: "10:13")
    var body: some View{
        CallRecordCell(recordData: $record)
    }
}

#Preview {
    CallRecordCellTestView()
}
