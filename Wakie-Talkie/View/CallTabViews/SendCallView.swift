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
    @State private var isDismissed: Bool = false
    @StateObject private var audioRecorder: AudioRecordingFunc = AudioRecordingFunc()
    @StateObject private var audioEngine: AudioEngineFunc = AudioEngineFunc()
    private let audioFileDataUploader = AudioFileDataUploader()
    @State var postModel:UploadRecordingModel
    @State var isGeneratingResponse: Bool = false
    @State var isGeneratingRecord: Bool = false
    @State var languages = ["", "English", "Korean", "Japanese", "Chinese"]

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
                CustomCircleImg(imageUrl: aiProfile.profileImg ?? "", size: 160, shadow: 0, action:{})
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
                    //Text("decibel \(audioRecorder.dbLevel)")
                    
                    CustomButtonBig(text: "전화 끊기", action: {
                        self.isDismissed = true
                        print("너 전화 끊기 눌렀다 - SendCallView")
                        audioFileDataUploader.callEndFunc(model: postModel)
                        print("끊기 눌렀다 & audioFileDataUploader")
                        self.callReceived = false
                        self.audioRecorder.finishRecording(success: true)
                        print("record 꺼짐!!!! upload api 보내나..?")
                        print(" & audioRecorder finish Recording")
                        print(" & audioRecorder.dismiss")
                        audioEngine.dismiss()
                        print(" & audioEngine.dismiss")
                        
                        dismiss()
                    }, color: Color("Accent1"), isActive: .constant(true))
                }
                else{
                    Text("Speak " + String(languages[aiProfile.language]))
                        .fontWeight(.regular)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    CustomButtonBig(text: "전화 취소하기", action: {
                        dismiss()
                    }, color: Color("Accent1"), isActive: .constant(true))
                }
            }
        }.onAppear{
            audioFileDataUploader.callStartFunc(model: postModel)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.callReceived = true
                audioRecorder.playCallSoundAndStartRecording()
            }
        }
        .onChange(of: self.audioRecorder.isRecording){
            self.isGeneratingRecord = self.audioRecorder.isRecording
           // print("is it recording? " + String(self.audioRecorder.isRecording))
            if(!self.isDismissed && !self.audioRecorder.isRecording){
                self.isGeneratingResponse = true
                if(audioRecorder.audioFilePath != nil){
                    //"http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/upload-audio/"
                    audioFileDataUploader.uploadAudioFile(url: "http://localhost:8000/upload-audio/", model: postModel, audioFilePath: audioRecorder.audioFilePath?.path() ?? "") { result in
                        print("api upload audio")
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
            if(!self.isDismissed && !self.audioEngine.isPlaying){
                print("2. answer, 파일 재생이 끝났나요? ", self.audioEngine.isPlaying)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 이걸 하거나 아니면 재생하는 이펙트 소리에 공백 1초정도 추가하기
                audioRecorder.startRecording()
//                }
            }
        }
    }
}
//struct CallingTestView: View{
//    @State var aipofileData: AIProfile =
//        AIProfile(id: 1, nickname: "Alexis",profileImg: "ai_profile_img", description: "like watching animation and go out for a walk.", language: 1)
//    var body: some View{
//        SendCallView(aiProfile: aipofileData)
//    }
//}
//#Preview {
//    CallingTestView()
//}


