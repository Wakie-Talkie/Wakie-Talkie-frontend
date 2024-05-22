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
    @Published var isPlayerPlaying: Bool = false
    //var audioFilePath: URL!
    
    override init() {
        super.init()
    }
    
    func setupAudioPlayer(audioFilePath: URL) {
        do {
            print("prepare to play \(audioFilePath)")
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilePath)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        } catch {
            print("Failed to play")
        }
    }
    
    func playAudio(audioFilePath: URL){
        setupAudioPlayer(audioFilePath: audioFilePath)
        if (audioPlayer != nil && !audioPlayer.isPlaying){
            self.isPlayerPlaying = true
            audioPlayer.play()
        }else{
            print("audioPlayer nilll")
        }
    }
    func stopAudio(){
        audioPlayer.stop()
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer.stop()
        print("Did finish Playing")
        self.isPlayerPlaying = false
    }
}
