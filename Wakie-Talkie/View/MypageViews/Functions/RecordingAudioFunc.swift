//
//  RecordingAudioFunc.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import Foundation
import AVFoundation
import Combine

class RecordingAudioFunc: NSObject,ObservableObject {
    private var audioEngine = AVAudioEngine()
    private var audioPlayerNode = AVAudioPlayerNode()
    private var audioFileBuffer: AVAudioPCMBuffer?
    private var timer: AnyCancellable?
    private var audioFile: AVAudioFile?
    
    @Published var isPlaying = false
    @Published var progress: Double = 0.0
    @Published var duration: Double = 0.0

    override init() {
        super.init()
        setupAudioEngine()
    }
    
    private func setupAudioEngine() {
        audioEngine.attach(audioPlayerNode)
        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: AVAudioFormat(standardFormatWithSampleRate: 24000, channels: 1))
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    func prepareAudio(from url: URL){
        do {
            audioFile = try AVAudioFile(forReading: url)
            print("audio play path : \(url)")
            if let audioFile = audioFile {
                duration = Double(audioFile.length) / audioFile.processingFormat.sampleRate
                                
                audioPlayerNode.scheduleFile(audioFile, at: nil,  completionCallbackType: .dataPlayedBack) {
                    _ in
                    //self.isPlaying = false
                    print("Finished playing.")
                }
//                audioPlayerNode.play()
//                isPlaying = true
            }
        } catch {
            print("Error playing audio: \(error)")
        }
    }
    
    func loadAudio(data: Data) {
        do {
            let audioFile = try AVAudioFile(forReading: data.toTempURL())
            self.audioFile = audioFile
            let format = audioFile.processingFormat
            print(format)
            let frameCount = AVAudioFrameCount(audioFile.length)
            let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!
            
            try audioFile.read(into: buffer)
            audioFileBuffer = buffer
            duration = Double(audioFile.length) / audioFile.processingFormat.sampleRate
        } catch {
            print("Error loading audio: \(error)")
        }
    }
    
    func play() {
//        guard let buffer = audioFileBuffer else { return }
        
//        audioPlayerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
        audioPlayerNode.play()
        isPlaying = true
        
        startProgressTimer()
    }
    
    func pause() {
        audioPlayerNode.pause()
        isPlaying = false
        timer?.cancel()
    }
    
    func stop() {
        audioPlayerNode.stop()
        isPlaying = false
        timer?.cancel()
        progress = 0.0
    }
    
    private func startProgressTimer() {
        timer?.cancel()
        
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if let nodeTime = self.audioPlayerNode.lastRenderTime,
                   let playerTime = self.audioPlayerNode.playerTime(forNodeTime: nodeTime) {
                    self.progress = Double(playerTime.sampleTime) / playerTime.sampleRate
                }
            }
    }
    
    func skipForward(by seconds: Double) {
        guard let audioFile = audioFile else { return }
        let currentTime = progress
        let newTime = min(currentTime + seconds, duration)
        seek(to: newTime)
    }
    
    func skipBackward(by seconds: Double) {
        let currentTime = progress
        let newTime = max(currentTime - seconds, 0)
        seek(to: newTime)
    }
    
    func dismiss(){
        audioEngine.stop()
        isPlaying = false
    }
    
    private func seek(to time: Double) {
        guard let audioFile = audioFile else { return }
        
        let sampleTime = AVAudioFramePosition(time * audioFile.processingFormat.sampleRate)
        audioPlayerNode.stop()
        audioPlayerNode.scheduleSegment(audioFile, startingFrame: sampleTime, frameCount: AVAudioFrameCount(audioFile.length - sampleTime), at: nil, completionHandler: nil)
        audioPlayerNode.play()
    }
}

extension Data {
    func toTempURL() -> URL {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp3")
        try? self.write(to: tempURL)
        return tempURL
    }
}





//class RecordingAudioFunc: NSObject, ObservableObject{
//    private var audioEngine = AVAudioEngine()
//    private var audioPlayerNode = AVAudioPlayerNode()
////    private var audioFile: AVAudioFile!
//    private var audioFormat: AVAudioFormat?
//    var beepPlayer: AVAudioPlayer?
//    var audioPath: URL!
//    @Published var isPlaying: Bool = false
//    //var audioFilePath: URL!
//
//    override init() {
//        super.init()
//        setupAudioPlayer()
//    }
//
//    func setupAudioPlayer(){
//        print("셋업됐니??????????")
//        audioEngine.attach(audioPlayerNode)
//        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: nil)
//        do {
//            try audioEngine.start()
//        } catch {
//            print("Error starting audio engine: \(error)")
//        }
//    }
//    
//    func getRecordedAudioData (url: String, recordingId: Int) {
//        let setURL = url + String(recordingId)
//        
//        guard let validURL = URL(string: setURL) else {
//            print("invalid url")
////            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//            return
//        }
//
//        var request = URLRequest(url: validURL)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error)
////                completion(.failure(error))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("invalid response")
////                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
//                return
//            }
//
//            print("Response Status Code: \(httpResponse.statusCode)")
//            print("Response Headers: \(httpResponse.allHeaderFields)")
//
//            guard httpResponse.statusCode == 200 else {
//                print("Upload failed with status code: \(httpResponse.statusCode)")
////                completion(.failure(NSError(domain: "Invalid response", code: httpResponse.statusCode, userInfo: nil)))
//                return
//            }
//
//            guard let data = data else {
//                print("no data received")
////                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
//                return
//            }
//            
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("Response Body: \(responseString)")
//                return
//            }
//            DispatchQueue.main.async {
//                self.playAudio(data: data)
//            }
//            
//        }.resume()
//    }
//
//    private func playAudio(data: Data) {
//        do {
//            // Create AVAudioFormat based on the known format of the audio data
//            let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: 44100, channels: 2, interleaved: false)
//            self.audioFormat = format
//            
//            // Create AVAudioPCMBuffer
//            let frameCapacity = AVAudioFrameCount(data.count) / format!.streamDescription.pointee.mBytesPerFrame
//            guard let buffer = AVAudioPCMBuffer(pcmFormat: format!, frameCapacity: frameCapacity) else {
//                print("Failed to create PCM buffer")
//                return
//            }
//            buffer.frameLength = frameCapacity
//            
//            // Copy audio data to PCM buffer
//            data.withUnsafeBytes { audioBytes in
//                let audioBuffer = buffer.audioBufferList.pointee.mBuffers
//                memcpy(audioBuffer.mData, audioBytes.baseAddress, Int(audioBuffer.mDataByteSize))
//            }
//            
//            audioPlayerNode.scheduleBuffer(buffer) {
//                self.isPlaying = false
//            }
//
//            audioPlayerNode.play()
//            isPlaying = true
////            startProgressTimer(duration: Double(buffer.frameLength) / format.sampleRate)
//        } catch {
//            print("Error playing audio: \(error)")
//        }
//    }
//
//    func playAudioStream(data: Data) {
//        audioFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2)
//        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat!, frameCapacity: AVAudioFrameCount(data.count) / audioFormat!.streamDescription.pointee.mBytesPerFrame)!
//        buffer.frameLength = buffer.frameCapacity
//
//        data.withUnsafeBytes { (audioBytes: UnsafeRawBufferPointer) in
//            memcpy(buffer.audioBufferList.pointee.mBuffers.mData, audioBytes.baseAddress, Int(buffer.frameLength) * Int(audioFormat!.streamDescription.pointee.mBytesPerFrame))
//        }
//
//        audioPlayerNode.scheduleBuffer(buffer) {
//            self.isPlaying = false
//            print("Finished playing.")
//        }
//
//        audioPlayerNode.play()
//        isPlaying = true
//    }
//
//
////    func audioPlay(from url: URL){
////        setupAudioPlayer()
////        do {
////            audioFile = try AVAudioFile(forReading: url)
////            print("audio play path : \(url)")
////            if let audioFile = audioFile {
////                audioPlayerNode.scheduleFile(audioFile, at: nil,  completionCallbackType: .dataPlayedBack) {
////                    _ in
////                    self.isPlaying = false
////                    print("Finished playing.")
////                }
////                audioPlayerNode.play()
////                isPlaying = true
////            }
////        } catch {
////            print("Error playing audio: \(error)")
////        }
////    }
//
//    func dismiss(){
//        audioEngine.stop()
//        isPlaying = false
//    }
//}
