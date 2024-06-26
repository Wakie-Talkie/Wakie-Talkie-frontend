//
//  AudioFileDataUploader.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/18/24.
//

import Foundation
class AudioFileDataUploader: ObservableObject{
    @Published var audioData: Data?
    
    func loadRecordedAudioData(model: UploadRecordingModel,audioFilePath: String){
        getRecordedAudioData(model: model, audioFilePath: audioFilePath){ result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.audioData = data
                    print("response url!!!!!! \(data)")
                }
            case .failure(let error):
                print("Upload failed: \(error)")
            }
        }
    }
    
    func getRecordedAudioData (model: UploadRecordingModel,audioFilePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let setURL = "http://localhost:8000/upload-audio/"
//        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/upload-audio/"
        
        guard let validURL = URL(string: setURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let audioFileURL = URL(fileURLWithPath: audioFilePath)
        guard let audioFileData = try? Data(contentsOf: audioFileURL) else {
            completion(.failure(NSError(domain: "Unable to read audio file", code: 0, userInfo: nil)))
            return
        }

        var body = Data()
        
        // Add ai_partner_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"ai_partner_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.aiPartnerId)\r\n".data(using: .utf8)!)

        // Add user_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"user_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.userId)\r\n".data(using: .utf8)!)

        // Add audio file part
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"recorded_audio_file\"; filename=\"\(audioFileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: audio/m4a\r\n\r\n".data(using: .utf8)!)
        body.append(audioFileData)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body
        
        // Print request details for debugging
        print("Request URL: \(setURL)")
        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Request Body: \(String(data: body, encoding: .utf8) ?? "Unable to encode body")")
        
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
            completion(.success(data))
        }.resume()
    }
    
    
    func callStartFunc(model: UploadRecordingModel) {
        callStartData(model: model) { result in
            switch result {
            case .success(let responseStr):
                print(responseStr)
            case .failure(let error):
                print("Upload failed: \(error)")
            }
        }
    }
    func callStartData(model: UploadRecordingModel, completion: @escaping (Result< String, Error>) -> Void){
        guard let validURL = URL(string: "http://localhost:8000/call/start/"
//                                    "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/call/start/"
        ) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        
        var body = Data()
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Add ai_partner_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"ai_partner_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.aiPartnerId)\r\n".data(using: .utf8)!)

        // Add user_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"user_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.userId)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body
        
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

            guard httpResponse.statusCode == 200 else {
                print("Upload failed with status code: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "Invalid response", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
        }.resume()
    }
    
    func callEndFunc(model: UploadRecordingModel) {
        callEndData(model: model) { result in
            switch result {
            case .success(let responseStr):
                print(responseStr)
            case .failure(let error):
                print("Upload failed: \(error)")
            }
        }
    }
    
    func callEndData(model: UploadRecordingModel, completion: @escaping (Result< String, Error>) -> Void){
        guard let validURL = URL(string: "http://localhost:8000/call/end/"
//                                    "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/call/end/"
        ) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        
        var body = Data()
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Add ai_partner_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"ai_partner_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.aiPartnerId)\r\n".data(using: .utf8)!)

        // Add user_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"user_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.userId)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body
        
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
        }.resume()
    }
   
    func uploadAudioFile(url: String, model: UploadRecordingModel, audioFilePath: String, completion: @escaping (Result<URL, Error>) -> Void){
        guard let validURL = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let audioFileURL = URL(fileURLWithPath: audioFilePath)
        guard let audioFileData = try? Data(contentsOf: audioFileURL) else {
            completion(.failure(NSError(domain: "Unable to read audio file", code: 0, userInfo: nil)))
            return
        }

        var body = Data()
        
        // Add ai_partner_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"ai_partner_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.aiPartnerId)\r\n".data(using: .utf8)!)

        // Add user_id
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"user_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(model.userId)\r\n".data(using: .utf8)!)

        // Add audio file part
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"recorded_audio_file\"; filename=\"\(audioFileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: audio/wav\r\n\r\n".data(using: .utf8)!)
        body.append(audioFileData)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        // Print request details for debugging
        print("Request URL: \(url)")
        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Request Body: \(String(data: body, encoding: .utf8) ?? "Unable to encode body")")

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
//            completion(.success(data))
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)")
            }

            let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("response_audio.wav")
            do {
                try data.write(to: tempFileURL)
                completion(.success(tempFileURL))
                print("temp file path:: \(tempFileURL)")
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
