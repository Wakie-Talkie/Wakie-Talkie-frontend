//
//  AudioPlayerFunc.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/29/24.
//

import Foundation
import AVFoundation

class AudioPlayerFunc: NSObject, AVAudioPlayerDelegate{
    var audioPlayer: AVAudioPlayer!
    //var audioFilePath: URL!
    
    override init() {
        super.init()
    }
    
    func setupAudioPlayer(audioFilePath: URL!) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilePath)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        } catch {
            print("Failed to play")
        }
    }
    func playAudio(){
        audioPlayer.play()
    }
    
    func getAudioPlaying() -> Bool{
        return audioPlayer.isPlaying ?? true
    }
}
