//
//  CallRecordCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct CallRecordCell: View {
    @Binding var recordData: Recording
    @State private var isPresentRecordTextView: Bool = false
    @State private var path = NavigationPath()
//    @State private var isTextViewActive = false
    var body: some View{
        NavigationStack(path: $path) {
            HStack(spacing: 15){
                CustomCircleImg(imageUrl: "ai_profile_me1",showEditBtn: false, size: 70)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                VStack(alignment: .leading){
                    Text("\(recordData.aiPartnerId)")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                    Text(String(recordData.language) + " - " + transTime(time: recordData.callingTime))
                        .fontWeight(.light)
                        .font(.system(size: 16))
                        .foregroundColor(Color("Black"))
                        .frame(alignment: .leading)
                }
                Spacer()
                 CustomButtonSmall(text: "기록보기", action: {
                     isPresentRecordTextView = true
                 }, isActive: .constant(true))
            }
            .frame(width: .infinity)
            .padding(5)
        }
        .navigationDestination(isPresented: $isPresentRecordTextView){
            CallRecordTextView(recordId: $recordData.id, dateTime: "\(recordData.date) \(recordData.callingTime)")
        }
    }
    func transTime(time: String)-> String{
        let arr = time.components(separatedBy: ":")
        return arr[0]+"분 "+arr[1]+"초"
    }
}
//struct CallRecordCellTestView: View{
//    @State var record: Recording = Recording(id: 1, userId: 1, aiPartnerId: 1, date: "2024-05-21", callingTime: "00:54", convertedTextFile: "", recordedAudioFile: "", language: 1)
//    var body: some View{
//        CallRecordCell(recordData: $record)
//    }
//}
//
//#Preview {
//    CallRecordCellTestView()
//}
