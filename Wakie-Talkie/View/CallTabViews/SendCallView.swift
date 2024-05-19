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
                    DotsAnimationView()
                    Text("만드는중")
                } else {
                    DecibelAnimationView(audioRecorder: audioRecorder)
                    Text("말해")
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



// 애니메이션 뷰 예제 (점 세 개가 차례로 나타났다 사라지는 애니메이션)
struct DotsAnimationView: View {
    @State private var showDot1: Bool = false
    @State private var showDot2: Bool = false
    @State private var showDot3: Bool = false

    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(Color.gray)
                .frame(width: 8, height: 8)
                .opacity(showDot1 ? 1 : 0)
            Circle()
                .fill(Color.gray)
                .frame(width: 8, height: 8)
                .opacity(showDot2 ? 1 : 0)
            Circle()
                .fill(Color.gray)
                .frame(width: 8, height: 8)
                .opacity(showDot3 ? 1 : 0)
        }
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.2)) { showDot1.toggle() }
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.4)) { showDot2.toggle() }
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.6)) { showDot3.toggle() }
    }
}


// 말하는 점 애니메이션

struct DecibelAnimationView: View {
    @ObservedObject var audioRecorder: AudioRecordingFunc

    var body: some View {
        HStack(spacing: 5) {
            DecibelBarView(dbLevel: audioRecorder.dbLevel)
            DecibelBarView(dbLevel: audioRecorder.dbLevel)
            DecibelBarView(dbLevel: audioRecorder.dbLevel)
        }
        .frame(height: 50)
    }
}

struct DecibelBarView: View {
    var dbLevel: Float

    var body: some View {
        let height = max(10, CGFloat((dbLevel + 100) / 2)) // 데시벨 값을 적절히 스케일링
        return RoundedRectangle(cornerRadius: 4)
            .fill(Color.gray)
            .frame(width: 8, height: height)
            .animation(.easeInOut(duration: 0.1), value: height) // 애니메이션 적용
    }
}
