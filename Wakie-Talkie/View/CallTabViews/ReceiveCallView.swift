//
//  ReceiveCallView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/29/24.
//

import SwiftUI

struct ReceiveCallView: View {
    @Environment(\.dismiss) var dismiss
    @State var aiProfile: AIProfile
    @State private var callReceived: Bool = false
    //@State private var isRecoding: Bool = false
    @State private var audioRecorder: AudioRecordingFunc = AudioRecordingFunc()
    @State private var audioPlayer: AudioPlayerFunc = AudioPlayerFunc()
    
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
                    Text("전화 요청")
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
                    Text(self.audioRecorder.getRecording() ? String(self.audioRecorder.getDecibelLevel()) : "")
                    Text(self.audioRecorder.getRecording() ? "recording" : "playing")
                    CustomButtonBig(text: "전화 끊기", action: {
                        self.callReceived = false
                        self.audioRecorder.finishRecording(success: true)
                        dismiss()
                    }, color: Color("Accent1"), isActive: .constant(true))
                }
                else{
                    Text("Speak " + aiProfile.language)
                        .fontWeight(.regular)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    CustomButtonBig(text: "전화 받기", action: {
                        self.callReceived = true
                        audioRecorder.startRecording()
                    }, color: Color("Black"), isActive: .constant(true))
                }
            }
        }
        .onChange(of: self.audioRecorder.getRecording()){
            //logic problem
            if(!self.audioRecorder.getRecording()){
                print("seting audioplayer")
                audioPlayer.setupAudioPlayer(audioFilePath: audioRecorder.getDocumentsDirectory())
                audioPlayer.playAudio()
            }
        }
//        .onChange(of: audioRecorder.getDocumentsDirectory()){
//            if(self.audioPlayer.audioPlayer != nil && !self.audioPlayer.getAudioPlaying()){
//                print("recording restart")
//                audioRecorder.startRecording()
//            }
//        }
    }
}
struct ReceiveCallTestView: View{
    @State var aipofileData: AIProfile =
        AIProfile(id: "aiNo.1", nickname: "Alexis",profileImg: "ai_profile_img", description: "like watching animation and go out for a walk.", language: "ENGLISH")
    var body: some View{
        ReceiveCallView(aiProfile: aipofileData)
    }
}
#Preview {
    ReceiveCallTestView()
}

