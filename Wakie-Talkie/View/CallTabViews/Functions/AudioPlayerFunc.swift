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
    
    func setupAudioPlayer(audioFilePath: URL!) {
        do {
            print("prepare to play \(audioFilePath)")
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilePath)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        } catch {
            print("Failed to play")
        }
    }
    func playAudio(){
        if (audioPlayer != nil && !audioPlayer.isPlaying){
            audioPlayer.play()
            DispatchQueue.main.async {
                self.isPlayerPlaying = true
            }
        }else{
            print("audioPlayer nilll")
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Did finish Playing")
        DispatchQueue.main.async {
            self.isPlayerPlaying = false
        }
    }
}
