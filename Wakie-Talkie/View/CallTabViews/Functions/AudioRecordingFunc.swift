//
//  File.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import Foundation
import AVFoundation
//NSObject, ObservableObject,
class AudioRecordingFunc:NSObject, AVAudioRecorderDelegate, ObservableObject{
    @Published var dbLevel: Float = 0.0
    @Published var isRecording: Bool = false
    @Published var audioFilePath: URL?
    var audioRecorder: AVAudioRecorder?
    var recordingSession: AVAudioSession
    var levelTimer: Timer?
    let silenceThreshold: Float = -27.0 // dB
    let maxSilenceDuration: TimeInterval = 1.5 // 최대 지속 시간 (초)
    var silenceStartTime: Date?

    override init() {
        recordingSession = AVAudioSession.sharedInstance()
        super.init()
        setupAudioSession()
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
        print("==레코딩 시작!!!")
        let audioFilename = getDocumentsDirectory()
        self.audioFilePath = audioFilename
        print("오디오파일경로를 만들엇어용 \(self.audioFilePath)")
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
            } else {
                silenceStartTime = Date()
            }
        } else {
            silenceStartTime = nil
        }
    }

    func finishRecording(success: Bool) {
        audioRecorder?.stop()
        self.isRecording = self.audioRecorder?.isRecording ?? false
        levelTimer?.invalidate()
        levelTimer = nil
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
}
