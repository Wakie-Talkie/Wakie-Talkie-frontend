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
    private var audioFileBuffer: AVAudioPCMBuffer?
    private var audioFile: AVAudioFile!
    private var audioFormat: AVAudioFormat?
    var beepPlayer: AVAudioPlayer?
    var audioPath: URL!
    @Published var isPlaying: Bool = false
    //var audioFilePath: URL!

    override init() {
        super.init()
        setupAudioPlayer()
    }

    func setupAudioPlayer(){
        print("셋업됐니??????????")
        audioEngine.attach(audioPlayerNode)
        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: AVAudioFormat(standardFormatWithSampleRate: 24000, channels: 1))
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }

    func playAudioStream(data: Data) {
        do {
            let audioFile = try AVAudioFile(forReading: data.toTempURL())
            self.audioFile = audioFile
            let format = audioFile.processingFormat
            print(format)
            let frameCount = AVAudioFrameCount(audioFile.length)
            let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!
            
            try audioFile.read(into: buffer)
            audioFileBuffer = buffer
        } catch {
            print("Error loading audio: \(error)")
        }

        if (audioFileBuffer != nil){
            audioPlayerNode.scheduleBuffer(audioFileBuffer!) {
                self.isPlaying = false
                print("Finished playing.")
            }
        }

        audioPlayerNode.play()
        isPlaying = true
    }


    func audioPlay(from url: URL){
        do {
            audioFile = try AVAudioFile(forReading: url)
            print("audio play path : \(url)")
            if let audioFile = audioFile {
                audioPlayerNode.scheduleFile(audioFile, at: nil,  completionCallbackType: .dataPlayedBack) {
                    _ in
                    //self.isPlaying = false
                    self.playBeep()
                    print("Finished playing.")
                }
                audioPlayerNode.play()
                isPlaying = true
            }
        } catch {
            print("Error playing audio: \(error)")
        }
    }

    func dismiss(){
        audioPlayerNode.pause()
        print(" & node pause?????")
        audioEngine.pause()
        print(" & engine pause?????")
        audioPlayerNode.stop()
        print(" & node pause?????")
        audioEngine.stop()
        print(" & engine pause?????")
        audioEngine.reset()
//
//        audioPlayerNode.stop()
//        print(" & node stop?????")
//        audioEngine.stop()
//        print(" & engine stop?????")
        isPlaying = false

    }
    func playBeep() {
        guard let beepPath = Bundle.main.url(forResource: "mute", withExtension: "wav") else {
            print("mute.mp3 파일을 찾을 수 없습니다.")
            return
        }

        do {
            beepPlayer = try AVAudioPlayer(contentsOf: beepPath)
            beepPlayer?.delegate = self
            beepPlayer?.play()
        } catch {
            print("mute.mp3 파일을 재생하는 중 오류 발생: \(error)")
        }
    }

}

extension AudioEngineFunc: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if player == beepPlayer {
            print("mute.mp3 파일 재생 완료")
            DispatchQueue.main.async {
                self.isPlaying = false
            }
        }
    }
}
