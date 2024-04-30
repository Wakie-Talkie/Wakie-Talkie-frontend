//
//  AudioPlayerFunc.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/29/24.
//

import Foundation
import AVFoundation

class AudioPlayerFunc: NSObject,ObservableObject, AVAudioPlayerDelegate{
    var audioPlayer: AVAudioPlayer!
    @Published var isPlayerPlaying: Bool = false{
        willSet {
            if newValue == true {
                playAudio()
            }
        }
    }
    //var audioFilePath: URL!
    
    override init() {
        super.init()
    }
    
    func setupAudioPlayer(audioFilePath: URL!) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilePath)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            print("prepare to play \(audioFilePath)")
        } catch {
            print("Failed to play")
        }
    }
    func playAudio(){
//        if (audioPlayer != nil && !audioPlayer.isPlaying){
//            audioPlayer.play()
//            isPlayerPlaying = true
//        }else{
//            print("audioPlayer nilll")
//        }
        audioPlayer.play()
        isPlayerPlaying = true
        
    }
    
    func getAudioPlaying() -> Bool{
        return audioPlayer.isPlaying ?? true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Did finish Playing")
        isPlayerPlaying = false
    }
}
