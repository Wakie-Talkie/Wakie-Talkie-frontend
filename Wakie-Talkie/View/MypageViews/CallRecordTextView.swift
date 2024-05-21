//
//  CallRecordDetailView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import SwiftUI

struct CallRecordTextView: View {
    @Binding var isTextViewActive: Bool
    @Binding var isRecordViewActive: Bool
//    @Binding var path: NavigationPath
    @Binding var recordId: Int
    var dateTime: String
    
    @State private var conversationScript: String = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var recordData = RecordingDataFetcher()
//    @State var isPresentRecordAudioView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            Image("record_background")
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                }
                VStack{
                    HStack {
                        Button(action: {dismiss()}, label: {
                            Text("<")
                                .fontWeight(.thin)
                                .font(.system(size: 25))
                                .foregroundColor(Color("Black"))
                                .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                        })
                        Spacer()
                        Text(dateTime)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                        Spacer()
                        Text("")
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
                    }
                    ScrollView{
                        Text(conversationScript)
                    }
                    
                    CustomButtonBig(text: "녹음 듣기", action: {
                        isTextViewActive = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isRecordViewActive = true
                        }
                    }, color: Color("Black"), isActive: .constant(true))
                    .frame(alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
            }
        }
        .onAppear(perform: {
            print("text appearrr")
            recordData.getRecordedTextData(url: "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/recordings/text/", recordingId: recordId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let resultText):
                        DispatchQueue.main.async {
                            conversationScript = resultText
                            print("response url!!!!!! \(resultText)")
                        }
                    case .failure(let error):
                        print("Upload failed: \(error)")
                    }
                }
            }
        })
//        .fullScreenCover(isPresented: $isPresentRecordAudioView, content: {
//
//        })
    }
}
