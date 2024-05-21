//
//  CallRecordDetailView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import SwiftUI

enum ChatCell {
    case user(text: String)
    case assistant(text: String)
}

struct CallRecordTextView: View {
    @Binding var isTextViewActive: Bool
    @Binding var isRecordViewActive: Bool
//    @Binding var path: NavigationPath
    @Binding var recordId: Int
    var dateTime: String
    
    @State private var chatCells: [ChatCell] = []
    @State private var conversationScript: String = ""
    @Environment(\.dismiss) var dismiss
    @StateObject var recordData = RecordingDataFetcher()
//    @State var isPresentRecordAudioView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        HStack {
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
                        ForEach(chatCells.indices, id: \.self) { index in
                            switch chatCells[index] {
                            case .user(let text):
                                CustomUserChatCell(text: text)
                            case .assistant(let text):
                                CustomAiChatCell(text: text)
                            }
                        }
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
        .onChange(of: conversationScript){
            chatCells = parseChat(text: conversationScript)
        }
//        .fullScreenCover(isPresented: $isPresentRecordAudioView, content: {
//
//        })
    }
    
    func parseChat(text: String) -> [ChatCell] {
        var chatCells: [ChatCell] = []
        let lines = text.split(separator: "\n").map { String($0) }
        
        for i in stride(from: 0, to: lines.count, by: 2) {
            if i + 1 < lines.count {
                let roleLine = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
                let contentLine = lines[i + 1].replacingOccurrences(of: "content: ", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                
                if roleLine.contains("role: user") {
                    chatCells.append(.user(text: contentLine))
                } else if roleLine.contains("role: assistant") {
                    chatCells.append(.assistant(text: contentLine))
                }
            }
        }
        
        return chatCells
    }
}
