//
//  AudioEngineFunc.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/30/24.
//

import Foundation
import AVFoundation

class AudioEngineFunc: NSObject, ObservableObject{
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioPath: URL!
    @Published var isPlaying: Bool = false
    //var audioFilePath: URL!
    
    override init() {
        super.init()
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
    }
    
    func setupAudioPlayer(audioFilePath: URL!) {
        var file: AVAudioFile!
        audioPath = audioFilePath
        do {
            file = try AVAudioFile(forReading: audioPath)
        } catch{
            print("error occured from audiofile")
        }
        
        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: file.processingFormat)
        audioPlayerNode.scheduleFile(file, at: nil, completionCallbackType: .dataPlayedBack){
            _ in
            DispatchQueue.main.async {
                self.isPlaying = false
            }
            self.audioPlayerNode.stop()
            self.audioEngine.stop()
        }
    }
    
    func audioPlay(){
        do {
            try audioEngine.start()
            audioPlayerNode.play()
            DispatchQueue.main.async {
                self.isPlaying = true
            }
        }catch{
            print("errror while playing audio")
        }
    }
}
