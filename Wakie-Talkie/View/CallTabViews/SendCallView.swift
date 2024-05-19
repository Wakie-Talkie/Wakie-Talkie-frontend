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
    @StateObject private var audioRecorder: AudioRecordingFunc = AudioRecordingFunc()
    @StateObject private var audioEngine: AudioEngineFunc = AudioEngineFunc()
    private let audioFileDataUploader = AudioFileDataUploader()
    private let postModel = UploadRecordingModel(userId: 1, aiPartnerId: 1)
    @State var isGeneratingResponse: Bool = false
    @State var isGeneratingRecord: Bool = false

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
                
                if isGeneratingResponse {
                    DotsAnimationCell()
                    //Text("답변을 만들고 있어요")
                } else if isGeneratingRecord {
                    DecibelAnimationCell(audioRecorder: audioRecorder)
                
                }
                

                if callReceived{
                    Text("decibel \(audioRecorder.dbLevel)")
                    Text(self.audioRecorder.isRecording ? "recording" : "player")
                    CustomButtonBig(text: "전화 끊기", action: {
                        self.callReceived = false
                        self.audioRecorder.finishRecording(success: true)
                        audioEngine.dismiss()
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
               // audioFileDataUploader.callStartFunc()
                audioRecorder.playCallSoundAndStartRecording()
            }
        }
        .onChange(of: self.audioRecorder.isRecording){
            self.isGeneratingRecord = self.audioRecorder.isRecording
           // print("is it recording? " + String(self.audioRecorder.isRecording))
            if(!self.audioRecorder.isRecording){
                self.isGeneratingResponse = true
                if(audioRecorder.audioFilePath != nil){
                    audioFileDataUploader.uploadAudioFile(url: "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/upload-audio/" , model: postModel, audioFilePath: audioRecorder.audioFilePath?.path() ?? "") { result in
                        DispatchQueue.main.async {
                            self.isGeneratingResponse = false
                            switch result {
                            case .success(let responseURL):
                                DispatchQueue.main.async {
                                    print("response url!!!!!! \(responseURL)")
                                    audioEngine.audioPlay(from: responseURL)
                                }
                            case .failure(let error):
                                print("Upload failed: \(error)")
                            }
                        }
                    }
                    print("start player")
                }
            }
        }
        .onChange(of: self.audioEngine.isPlaying){
            if(!self.audioEngine.isPlaying){
                print("2. answer, 파일 재생이 끝났나요? ", self.audioEngine.isPlaying)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 이걸 하거나 아니면 재생하는 이펙트 소리에 공백 1초정도 추가하기
                    audioRecorder.startRecording()
                }
            }
        }
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


