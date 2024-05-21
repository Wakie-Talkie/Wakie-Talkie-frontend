//
//  RecordingAudioFunc.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import Foundation
import AVFoundation

class RecordingAudioFunc: NSObject, ObservableObject{
    private var audioEngine = AVAudioEngine()
    private var audioPlayerNode = AVAudioPlayerNode()
    private var audioFile: AVAudioFile!
    private var audioFormat: AVAudioFormat?
    var beepPlayer: AVAudioPlayer?
    var audioPath: URL!
    @Published var isPlaying: Bool = false
    //var audioFilePath: URL!

    override init() {
        super.init()
//        setupAudioPlayer()
    }

    func setupAudioPlayer(){
        print("셋업됐니??????????")
        audioEngine.attach(audioPlayerNode)
        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: nil)
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    func getRecordedAudioData (url: String, recordingId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let setURL = url + String(recordingId)
        
        guard let validURL = URL(string: setURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: validURL)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }

            print("Response Status Code: \(httpResponse.statusCode)")
            print("Response Headers: \(httpResponse.allHeaderFields)")

            guard httpResponse.statusCode == 200 else {
                print("Upload failed with status code: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "Invalid response", code: httpResponse.statusCode, userInfo: nil)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)")
                return
            }
            completion(.success("successssssss"))
            DispatchQueue.main.async {
                self.playAudioStream(data: data)
            }
            
        }.resume()
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
        setupAudioPlayer()
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
