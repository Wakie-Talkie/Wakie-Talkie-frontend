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
    private var audioFormat: AVAudioFormat?
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
    
    func playAudioStream(data: Data) {
        audioFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2)
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat!, frameCapacity: AVAudioFrameCount(data.count) / audioFormat!.streamDescription.pointee.mBytesPerFrame)!
        buffer.frameLength = buffer.frameCapacity

        data.withUnsafeBytes { (audioBytes: UnsafeRawBufferPointer) in
            memcpy(buffer.audioBufferList.pointee.mBuffers.mData, audioBytes.baseAddress, Int(buffer.frameLength) * Int(audioFormat!.streamDescription.pointee.mBytesPerFrame))
        }

        audioPlayerNode.scheduleBuffer(buffer) {
            self.isPlaying = false
            print("Finished playing.")
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
                    self.isPlaying = false
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
        audioEngine.stop()
        isPlaying = false
    }
}
