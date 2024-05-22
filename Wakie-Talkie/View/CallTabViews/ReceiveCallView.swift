//
//  ReceiveCallView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/28/24.
//

import SwiftUI
import SwiftData

struct ReceiveCallView: View {
    @Binding var navigateToReceiveCall: Bool
    
    @Environment(\.dismiss) var dismiss
    @State var aiProfile: AIProfile
    @State private var callReceived: Bool = false
    @StateObject private var audioRecorder: AudioRecordingFunc = AudioRecordingFunc()
//    @State private var audioEngine: AudioEngineFunc? = nil
    @StateObject private var audioPlayer: AudioPlayerFunc = AudioPlayerFunc()
    private let audioFileDataUploader = AudioFileDataUploader()
    private let postModel = UploadRecordingModel(userId: 1, aiPartnerId: 3) //temp
    @State var isGeneratingResponse: Bool = false
    @State var isGeneratingRecord: Bool = false
    
    @EnvironmentObject var alarmTimer: AlarmTimer
    @Query private var alarmList: [Alarm]
    
    
    
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
                if callReceived == false {
                    Text("전화 요청")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 80, trailing: 0))
                } else {
                    Text("통화중") //TODO: 이거 없애야돼.
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
                
                if callReceived {
                    CustomButtonBig(text: "전화 끊기", action: {
                        audioFileDataUploader.callEndFunc(model: postModel)
                        self.callReceived = false
                        self.audioRecorder.finishRecording(success: true)
                        audioRecorder.dismiss()
                        audioPlayer.dismiss()
                        dismiss()
                    }, color: Color("Accent1"), isActive: .constant(true))
                }
                else{
                    Text("Speak " + String(aiProfile.language))
                        .fontWeight(.regular)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    CustomButtonBig(text: "전화 받기", action: { callReceived = true //dismiss()
                        print("이게 트리거되는거야???")
                        audioRecorder.playPartnerSoundAndStartRecording(for: postModel.aiPartnerId)
                        //navigateToReceiveCall = false
                        AlarmManager.scheduleNextAlarm(alarms: alarmList)
                        alarmTimer.updateNextAlarmTime(time: (AlarmManager.findNextAlarmTime(alarms: alarmList) ) ?? Calendar.current.date(from: DateComponents(year: 2099, month: 1, day: 1))!) //TODO:empty array checking
                    }, color: Color("Black"), isActive: .constant(true))
                }
            }
        }.onAppear{
            print("뉴 오디오 엔진 레스고")
            let newAudioEngine = AudioEngineFunc()
            newAudioEngine.setupAudioPlayer()
            audioEngine = newAudioEngine
            audioEngine?.isPlaying = true
            print("뉴 오디오 엔진 할당됐음?아마도..")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//               // audioFileDataUploader.callStartFunc()
//                audioRecorder.playCallSoundAndStartRecording()
//            }
        }
        .onChange(of: self.audioRecorder.isRecording){
            self.isGeneratingRecord = self.audioRecorder.isRecording
           print("===is it recording? " + String(self.audioRecorder.isRecording))
            if(!self.audioRecorder.isRecording){
                self.isGeneratingResponse = true
                if(audioRecorder.audioFilePath != nil){
                    audioFileDataUploader.uploadAudioFile(model: postModel, audioFilePath: audioRecorder.audioFilePath?.path() ?? "") { result in
                        DispatchQueue.main.async {
                            self.isGeneratingResponse = false
                            switch result {
                            case .success(let url):
                                audioPlayer.playAudio(audioFilePath: url)
//                                DispatchQueue.main.async {
//                                    print("response url!!!!!! \(responseURL)")
//                                    audioEngine!.audioPlay(from: responseURL)
//                                }
                            case .failure(let error):
                                print("Upload failed: \(error)")
                            }
                        }
                    }
                    print("start player")
                }
            }
        }
        .onChange(of: self.audioPlayer.isPlayerPlaying){
            if(!(self.audioPlayer.isPlayerPlaying)){
                //print("2. answer, 파일 재생이 끝났나요? ", self.audioEngine?.isPlaying)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 이걸 하거나 아니면 재생하는 이펙트 소리에 공백 1초정도 추가하기
                    print("여긴가?.. 온체인지")
                    audioRecorder.startRecording()
//                }
            }
        }
    }
}
