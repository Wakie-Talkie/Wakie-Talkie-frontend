//
//  CustomProgressBar.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/22/24.
//

import SwiftUI

struct CustomProgressBar: View {
    @ObservedObject var recordingAudioFunc: RecordingAudioFunc
    var body: some View {
        VStack {
            ProgressView(value: recordingAudioFunc.progress, total: recordingAudioFunc.duration)
                .progressViewStyle(CustomProgressViewStyle(mainColor: Color("Accent1"), strokeColor: Color("Grey1"), strokeWidth: 10))
               .frame(width: UIScreen.main.bounds.width * 0.7, height: 7)
               .padding()
            
            HStack {
                Button(action: {
                    recordingAudioFunc.skipBackward(by: 10)
                }) {
                    Image("10s_back_btn")
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 5, trailing: UIScreen.main.bounds.width * 0.2))
                
                Button(action: {
                    if recordingAudioFunc.isPlaying {
                        recordingAudioFunc.pause()
                    } else {
                        recordingAudioFunc.play()
                    }
                }) {
                    Image( recordingAudioFunc.isPlaying ? "pause_btn" : "play_btn")
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 5, trailing: 0))
                
                
                Button(action: {
                    recordingAudioFunc.skipForward(by: 10)
                }) {
                    Image("10s_front_btn")
                }
                .padding(EdgeInsets(top: 15, leading: UIScreen.main.bounds.width * 0.2, bottom: 5, trailing: 0))
            }
        }
        .frame(maxWidth: .infinity)
    }
}
//
//struct CustomProgressBarTestView: View{
//    @State var play: Bool = false
//    var body: some View{
//        CustomProgressBar(isPalying: play)
//    }
//}
//
//#Preview {
//    CustomProgressBarTestView()
//}
