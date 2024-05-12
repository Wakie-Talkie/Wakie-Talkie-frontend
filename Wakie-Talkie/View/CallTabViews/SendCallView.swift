//
//  SendCallView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import SwiftUI

struct SendCallView: View {
    @Environment(\.dismiss) var dismiss
    @State var aiProfile: AIProfile
    @State private var callReceived: Bool = false
//    @State private var audioDecibel: String = ""
//    @State private var audioState: String = ""
//    @State private var isRecoding: Bool = false
//    @State private var isPlaying: Bool = false
    @StateObject private var audioRecorder: AudioRecordingFunc = AudioRecordingFunc()
    @StateObject private var audioEngine: AudioEngineFunc = AudioEngineFunc()
//    @StateObject private var audioPlayer: AudioPlayerFunc = AudioPlayerFunc()
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Image("calling_background")
                            .edgesIgnoringSafeArea(.all)
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            VStack(spacing: 10){
                if callReceived{
                    Text("통화중...")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 80, trailing: 0))
                }else{
                    Text("전화 거는 중...")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 80, trailing: 0))
                }
                
                Image(aiProfile.profileImg ?? "ai_profile_img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Text(aiProfile.nickname)
                    .fontWeight(.medium)
                    .font(.system(size: 25))
                    .foregroundColor(Color("Black"))
                Text(aiProfile.description ?? "")
                    .fontWeight(.thin)
                    .font(.system(size: 20))
                    .foregroundColor(Color("Black"))
                    .frame(width:250, alignment: .center)
                Spacer()
                
                if callReceived{
                    Text("decibel \(audioRecorder.dbLevel)")
                    Text(self.audioRecorder.isRecording ? "recording" : "player")
                    CustomButtonBig(text: "전화 끊기", action: {
                        self.callReceived = false
                        self.audioRecorder.finishRecording(success: true)
                        dismiss()
                    }, color: Color("Accent1"), isActive: .constant(true))
                }
                else{
                    Text("Speak " + String(aiProfile.language))
                        .fontWeight(.regular)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    CustomButtonBig(text: "전화 취소하기", action: {dismiss()}, color: Color("Accent1"), isActive: .constant(true))
                }
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.callReceived = true
//                isRecoding = self.audioRecorder.isRecording
//                isPlaying = self.audioPlayer.isPlayerPlaying
                audioRecorder.startRecording()
            }
        }
        .onChange(of: self.audioRecorder.isRecording){
            print("is it recording? " + String(self.audioRecorder.isRecording))
            if(!self.audioRecorder.isRecording){
                print("start player")
                audioEngine.setupAudioPlayer(audioFilePath: audioRecorder.audioFilePath)
                audioEngine.audioPlay()
//                audioPlayer.setupAudioPlayer(audioFilePath: audioRecorder.audioFilePath)
//                audioPlayer.playAudio()
            }
        }
        .onChange(of: self.audioEngine.isPlaying){
            if(!self.audioEngine.isPlaying){
                audioRecorder.startRecording()
            }
        }
//        .onChange(of: self.audioRecorder.getDecibelLevel()){
//            audioDecibel = String(self.audioRecorder.getDecibelLevel())
//        }
//        .onChange(of: self.audioRecorder.getRecording()){
//            print("audio recording??: " + String(self.audioRecorder.getRecording()))
//            //logic problem
//            if(!self.audioRecorder.getRecording()){
//                audioState = "playing"
//                audioDecibel = "00"
//                print("seting audioplayer")
//                audioPlayer.setupAudioPlayer(audioFilePath: audioRecorder.getDocumentsDirectory())
//                audioPlayer.playAudio()
//            }
//        }
//        .onChange(of: audioRecorder.getDocumentsDirectory()){
//            if(self.audioPlayer.audioPlayer != nil && !self.audioPlayer.getAudioPlaying()){
//                print("recording restart")
//                audioRecorder.startRecording()
//            }
//        }
    }
}
struct CallingTestView: View{
    @State var aipofileData: AIProfile =
        AIProfile(id: 1, nickname: "Alexis",profileImg: "ai_profile_img", description: "like watching animation and go out for a walk.", language: 1)
    var body: some View{
        SendCallView(aiProfile: aipofileData)
    }
}
//#Preview {
//    CallingTestView()
//}
