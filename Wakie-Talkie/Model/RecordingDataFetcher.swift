//
//  RecordoingDataFetcher.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import Combine
import Foundation

class RecordingDataFetcher: ObservableObject {
    @Published var records: [Recording] = []
    @Published var script: String = ""
    func loadRecordData() {
        getRecordData { [weak self] recordData in
            DispatchQueue.main.async {
                self?.records = recordData
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
       }
    }
    
    func getRecordData(completion: @escaping ([Recording]) -> Void){
        HTTPManager.requestGET(url:
        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/recordings/"
        ) { data in
            guard let data: [Recording] = JSONConverter.decodeJsonArray(data: data) else { return
            }
            completion(data)
        }
    }
    
    func loadTextData(recordingId: Int){
        getRecordedTextData(url: "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/recordings/text/", recordingId: recordingId){ result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.script = result
                    print("response url!!!!!! \(result)")
                }
            case .failure(let error):
                print("Upload failed: \(error)")
            }
        }
    }
    
    func getRecordedTextData (url: String, recordingId: Int, completion: @escaping (Result<String, Error>) -> Void) {
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
                completion(.success(responseString))
            }
        }.resume()
    }
    
    func getRecordedAudioData (url: String, recordingId: Int, completion: @escaping (Result<URL, Error>) -> Void) {
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
            }

            let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("combined_recording.mp3")
            do {
                try data.write(to: tempFileURL)
                print("data type?? : \(type(of: data))")
                completion(.success(tempFileURL))
                print("temp file path:: \(tempFileURL)")
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
