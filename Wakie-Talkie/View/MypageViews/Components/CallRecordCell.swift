//
//  CallRecordCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct CallRecordCell: View {
    @Binding var recordData: Recording
//    @State var isPresentRecordTextView: Bool = false
    @State private var path = NavigationPath()
    @State private var isTextViewActive = false
    @State private var isRecordViewActive = false
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
                NavigationLink(destination: CallRecordTextView(isTextViewActive: $isTextViewActive, isRecordViewActive: $isRecordViewActive, recordId: $recordData.id, dateTime: "\(recordData.date) \(recordData.callingTime)"), isActive: $isTextViewActive) {
                    CustomButtonSmall(text: "기록보기", action: {isTextViewActive = true}, isActive: .constant(true))
                }
            }
            .frame(minWidth: 300,minHeight: 100)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            .navigationDestination(isPresented: $isRecordViewActive) {
                CallRecordAudioView(isTextViewActive: $isTextViewActive, isRecordViewActive: $isRecordViewActive, recordId: $recordData.id, dateTime: "\(recordData.date) \(recordData.callingTime)")
            }
//            .navigationDestination(isPresented: $isTextViewActive) {
//                CallRecordTextView(isTextViewActive: $isTextViewActive, isRecordViewActive: $isRecordViewActive, recordId: $recordData.id, dateTime: "\(recordData.date) \(recordData.callingTime)")
//            }
//            .navigationDestination(for: String.self) { value in
//                if value == "Text" {
//                    CallRecordTextView(path: $path, recordId: $recordData.id, dateTime: "\(recordData.date) \(recordData.callingTime)")
//                } else if value == "Record" {
//                    CallRecordAudioView(path: $path, dateTime: "\(recordData.date) \(recordData.callingTime)", recordId: $recordData.id)
//                }
//            }
        }
    }
    
    func transTime(time: String)-> String{
        let arr = time.components(separatedBy: ":")
        return arr[0]+"분 "+arr[1]+"초"
    }
}
struct CallRecordCellTestView: View{
    @State var record: Recording = Recording(id: 1, userId: 1, aiPartnerId: 1, date: "2024-05-21", callingTime: "00:54", convertedTextFile: "", recordedAudioFile: "", language: 1)
    var body: some View{
        CallRecordCell(recordData: $record)
    }
}

#Preview {
    CallRecordCellTestView()
}
