//
//  AudioEngineFunc.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/30/24.
//

import Foundation
import AVFoundation

class AudioEngineFunc: NSObject, ObservableObject{
    private var audioEngine = AVAudioEngine()
    private var audioPlayerNode = AVAudioPlayerNode()
    private var audioFile: AVAudioFile!
    var audioPath: URL!
    @Published var isPlaying: Bool = false
    //var audioFilePath: URL!

    override init() {
        super.init()
        setupAudioPlayer()
    }

    func setupAudioPlayer(){
        audioEngine.attach(audioPlayerNode)
        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: nil)
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }

//    func setupAudioPlayer(audioFilePath: URL!) {
//        var file: AVAudioFile!
//        audioPath = audioFilePath
//        do {
//            file = try AVAudioFile(forReading: audioPath)
//        } catch{
//            print("error occured from audiofile")
//        }
//
//        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: file.processingFormat)
//        audioPlayerNode.scheduleFile(file, at: nil, completionCallbackType: .dataPlayedBack){
//            _ in
//            self.isPlaying = false
//            self.audioPlayerNode.stop()
//            self.audioEngine.stop()
//        }
//    }

    func audioPlay(from url: URL){
        do {
            audioFile = try AVAudioFile(forReading: url)
            print("audio play path : \(url)")
            if let audioFile = audioFile {
                audioPlayerNode.scheduleFile(audioFile, at: nil,  completionCallbackType: .dataPlayedBack) {
                    _ in
                    self.isPlaying = false
                    print("Finished playing.")
                }
                audioPlayerNode.play()
                isPlaying = true
//=======
//    }

//    func setupAudioPlayer(audioFilePath: URL!) {
//        var audioFile: AVAudioFile!

//        print("내가받은 오디오 패스는 이렇다", audioFilePath)
//        do {
//            audioFile = try AVAudioFile(forReading: audioFilePath)
//        } catch {
//            print("error occured from audiofile")
//        }


//        print("ㅎㅓㄱ 설마 여기로?")
//        audioPlayerNode.scheduleFile(audioFile, at: nil, completionCallbackType: .dataPlayedBack){
//            _ in
//            DispatchQueue.main.async {
//                self.isPlaying = false
//                print("오디오 재생 false로 변화?", self.isPlaying)
//            }
////            self.audioPlayerNode.stop()
////            self.audioEngine.stop()
//        }
//        print("ㄱㅡㄷㅏ음?")
//    }

//    func audioPlay(){
//        do {
//            try audioEngine.start()
//            audioPlayerNode.play()
//            DispatchQueue.main.async {
//                self.isPlaying = true
//                print("오디오 재생 true로 변화?", self.isPlaying)
//                print(self.isPlaying)
//>>>>>>> Stashed changes
            }
        } catch {
            print("Error playing audio: \(error)")
        }
    }
}
