//
//  File.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import Foundation
import AVFoundation
//NSObject, ObservableObject,
class AudioRecordingFunc:NSObject, AVAudioRecorderDelegate, ObservableObject, AVAudioPlayerDelegate{
    @Published var dbLevel: Float = 0.0
    @Published var isRecording: Bool = false
    @Published var audioFilePath: URL?
    var audioRecorder: AVAudioRecorder?
    var recordingSession: AVAudioSession
    var soundPlayer: AVAudioPlayer?
    var levelTimer: Timer?
    let silenceThreshold: Float = -27.0 // dB
    let maxSilenceDuration: TimeInterval = 1.5 // 최대 지속 시간 (초)
    var silenceStartTime: Date?

    override init() {
        recordingSession = AVAudioSession.sharedInstance()
        super.init()
        setupAudioSession()
    }

    func dismiss(){
        audioRecorder?.stop()
        //print(" & recorder stop?????")
    }
    private func setupAudioSession() {
        do {
            try recordingSession.setCategory(.playAndRecord, options: [.defaultToSpeaker])
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission {
                (accepted) in
                if accepted{
                    print("permission granted")
                }
            }
        } catch {
            print("Failed to set up audio session")
        }
    }

    func startRecording() {
        //print("==레코딩 시작!!!")
        let audioFilename = getDocumentsDirectory()
        self.audioFilePath = audioFilename
        //print("오디오파일경로를 만들엇어용 \(self.audioFilePath)")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMIsBigEndianKey: false,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ] as [String : Any]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            self.isRecording = self.audioRecorder?.isRecording ?? false
            silenceStartTime = Date()
            startLevelTimer()
        } catch {
            finishRecording(success: false)
        }
    }

    func getRecording() -> Bool{
        return audioRecorder?.isRecording ?? true
    }
    func getDecibelLevel()->Float{
        return dbLevel
    }

    private func startLevelTimer() {
        levelTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [unowned self] _ in
            updateAudioLevels()
        }
    }

    private func updateAudioLevels() {
        audioRecorder?.updateMeters()
        let level = audioRecorder?.averagePower(forChannel: 0) ?? 0
        print("decibel", String(level))
        dbLevel = level
        if level < silenceThreshold {
            if let silenceStartTime = silenceStartTime {
                if Date().timeIntervalSince(silenceStartTime) >= maxSilenceDuration {
                    finishRecording(success: true)
                }
               // print("=== if\(silenceStartTime)")
                //print("=== if 시간차 \(Date().timeIntervalSince(silenceStartTime))")
            } else {
                silenceStartTime = Date()
             //   print("=== else문이라서 date초기화에욤\(String(describing: silenceStartTime))")
            }
        } else {
            silenceStartTime = Date() // nil이어서 오류나는거같은데
          //  print("=== nil이어욤\(String(describing: silenceStartTime))")
        }
    }

    func finishRecording(success: Bool) {
        if self.isRecording{
            audioRecorder?.stop()
        }
        self.isRecording = self.audioRecorder?.isRecording ?? false
        if(levelTimer != nil){
            if (levelTimer!.isValid){
                levelTimer?.invalidate()
            }
            levelTimer = nil
        }
        if success {
            print("Recording finished successfully.")
        } else {
            print("Recording failed or was interrupted.")
        }
    }

    func getDocumentsDirectory() -> URL {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            self.audioFilePath = paths[0].appending(path:(dateFormatter.string(from: Date.now)+".wav"))
        return audioFilePath!
    }

    func playCallSoundAndStartRecording() {
        guard let callSoundPath = Bundle.main.url(forResource: "dialtone", withExtension: "wav") else {
            print("dialtone.wav 파일을 찾을 수 없습니다.")
            return
        }
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: callSoundPath)
            soundPlayer?.delegate = self
            soundPlayer?.play()
        } catch {
            print("dialtone.wav 파일을 재생하는 중 오류 발생: \(error)")
        }
    }

    func playPartnerSoundAndStartRecording(for partnerId: Int) {
            let fileNames = [
                36: "alloys",
                37: "echo",
                38: "fable",
                4: "nova",
                5: "onyx",
                6: "shimmer"
            ]

            guard let fileName = fileNames[partnerId], let partnerSoundPath = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
                print("파트너 파일을 찾을 수 없습니다.")
                return
            }

            do {
                soundPlayer = try AVAudioPlayer(contentsOf: partnerSoundPath)
                soundPlayer?.delegate = self
                soundPlayer?.play()
            } catch {
                print("파트너 파일을 재생하는 중 오류 발생: \(error)")
            }
        }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if player == soundPlayer {
            print("dialtone.wav 파일 재생 완료")
            DispatchQueue.main.async {
                self.startRecording()
            }
        }
    }
}
