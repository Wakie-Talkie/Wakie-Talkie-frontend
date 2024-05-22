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
    @Binding var recordId: Int
    var dateTime: String
    
    @State private var chatCells: [ChatCell] = []
    @State private var conversationScript: String = ""
    @Environment(\.dismiss) var dismiss
    @StateObject var recordData = RecordingDataFetcher()
    @StateObject private var recordingAudioFunc = RecordingAudioFunc()
    
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
                    VStack {
                        ProgressView(value: recordingAudioFunc.progress, total: recordingAudioFunc.duration)
                            .progressViewStyle(LinearProgressViewStyle(tint: .pink))
                            .padding()
                        
                        HStack {
                            Button(action: {
                                recordingAudioFunc.skipBackward(by: 10)
                            }) {
                                Image(systemName: "gobackward.10")
                                    .font(.system(size: 24))
                            }
                            .padding()
                            
                            Button(action: {
                                if recordingAudioFunc.isPlaying {
                                    recordingAudioFunc.pause()
                                } else {
                                    recordingAudioFunc.play()
                                }
                            }) {
                                Image(systemName: recordingAudioFunc.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 48))
                            }
                            .padding()
                            
                            Button(action: {
                                recordingAudioFunc.skipForward(by: 10)
                            }) {
                                Image(systemName: "goforward.10")
                                    .font(.system(size: 24))
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: {
            recordData.loadTextData(recordingId: recordId)
            recordData.loadRecordedAudioData(recordingId: recordId)
        })
        .onChange(of: recordData.script){
            conversationScript = recordData.script
            chatCells = parseChat(text: conversationScript)
        }
        .onChange(of: recordData.audioData){
            if (recordData.audioData != nil){
                recordingAudioFunc.loadAudio(data: recordData.audioData!)
            }
        }
        .navigationBarBackButtonHidden(true)
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
