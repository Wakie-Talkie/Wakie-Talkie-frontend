//
//  File.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import Combine
import Foundation
import SwiftUI

class AIProfileDataFetcher: ObservableObject {
    @Published var aiProfiles: [AIProfile]?
    @Published var aiProfile: AIProfile?
    func loadAiProfileData() {
//        self.aiProfiles = [AIProfile(id: 1, nickname: "a", description: "b", language: 1),AIProfile(id: 2, nickname: "b", language: 2), AIProfile(id: 3, nickname: "ccc",description: "kk", language: 4) ]
        getAiProfileData { [weak self] aiProfilesData in
            DispatchQueue.main.async {
                self?.aiProfiles = aiProfilesData
            //    print("aiprofiledata?: ",aiProfilesData)
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
       }
        print(aiProfiles ?? "nothing")
    }
    func loadAiProfileSortedData() {
        getAiProfileData { [weak self] aiProfilesData in
            DispatchQueue.main.async {
                self?.aiProfiles = aiProfilesData.sorted{$0.language < $1.language}
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
        }
    }
    // en:1 ko:2 ja:4 zh:5
    func loadAiProfileDataFromLang(language: Int) {
        getAiProfileDataFromLang(language: language) { [weak self] aiProfilesData in
            DispatchQueue.main.async {
                self?.aiProfiles = aiProfilesData
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
        }
    }
    
    func loadAiProilDataById(aiUserId: Int){
        getAiProfileDataById(aiUserId: aiUserId) { [weak self] aiProfilesData in
            DispatchQueue.main.async {
                self?.aiProfile = aiProfilesData
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
        }
    }

    func getAiProfileData(completion: @escaping ([AIProfile]) -> Void){
        HTTPManager.requestGET(url: "http://localhost:8000/ai-users/"
//        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/"
        ) { data in
            guard let data: [AIProfile] = JSONConverter.decodeJsonArray(data: data)
            else {
                return
            }
            
            completion(data)
        }
    }
    
    func getAiProfileDataById(aiUserId: Int,completion: @escaping (AIProfile) -> Void){
        HTTPManager.requestGET(url: "http://localhost:8000/ai-users/\(aiUserId)"
//        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/\(aiUserId)"

        ) { data in
            guard let data: AIProfile = JSONConverter.decodeJson(data: data) else { return
            }
            completion(data)
        }
    }

    func getAiProfileDataFromLang(language: Int, completion: @escaping ([AIProfile]) -> Void){
        HTTPManager.requestGET(url: "http://localhost:8000/ai-users/language/\(language)/"
//       "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/language/\(language)/"
        ) { data in
            guard let data: [AIProfile] = JSONConverter.decodeJsonArray(data: data) else { return
            }
            completion(data)
        }
    }
    
    func postCustomAiProfile( nickname: String, profileImage: UIImage?, description: String?, language: Int, completion: @escaping (Result< String, Error>) -> Void) {
        let setURL = "http://localhost:8000/ai-users/"
//        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/"
        
        guard let validURL = URL(string: setURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let httpBody = createMultipartBody(boundary: boundary, parameters: [
                "nickname": nickname,
                "ai_type": "custom",
                "description": description ?? "",
                "language": "\(language)"
            ], image: profileImage, imageKey: "profile_img")
            
            request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            completion(.success(responseString))
        }
            
        task.resume()
        
    }
    
    func createMultipartBody(boundary: String, parameters: [String: String], image: UIImage?, imageKey: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 1.0) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"profile.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    // custom ai 만들 때 파일을 업로드하는 코드.
    func postCustomAiProfileFile(voiceFileURL: URL?, nickname: String, completion: @escaping (Result< String, Error>) -> Void) {
        let setURL = "http://localhost:8000/ai-users/upload-ai-voice/"
//        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/upload-ai-voice/"
        
        guard let validURL = URL(string: setURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        if voiceFileURL == nil {
            print("invalid file url")
            return
        }
        
        let httpBody = createBody(with: voiceFileURL!, nickname: nickname, boundary: boundary)
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                   completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                   return
               }
               
               completion(.success(responseString))
           }
           
        task.resume()
    }
    
    func createBody(with fileURL: URL, nickname: String, boundary: String) -> Data {
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        // Add ai nickname part
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"ai_name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(nickname)\r\n".data(using: .utf8)!)
        
        // Add file part
        let filename = fileURL.lastPathComponent
        let mimeType = "audio/mpeg" // MIME type should be set accordingly
        let fileData = try? Data(contentsOf: fileURL)
        
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"ai_voice_file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        if let fileData = fileData {
            body.append(fileData)
        }
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }

//    func getAIProfiles(){
//        self.aiProfiles = []
//        guard let url = URL(string: "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/") else{ fatalError("Missing url") }
//        let urlRequest = URLRequest(url: url)
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else{ return }
//
//            if response.statusCode == 200 {
//                guard let data = data else {return}
//                DispatchQueue.main.async {
//                    do{
//                        let decodedResponse = try JSONDecoder().decode([AIProfile].self, from: data)
//                        self.aiProfiles = decodedResponse
//                    }catch let error{
//                        print("Error decodeing: ", error)
//                    }
//                }
//            }
//        }
//        dataTask.resume()
//    }
//
//    func getLanguageAIProfiles(language: Int){
//        self.aiProfiles = []
//        guard let url = URL(string: "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/language/\(language)") else{ fatalError("Missing url") }
//        let urlRequest = URLRequest(url: url)
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else{ return }
//
//            if response.statusCode == 200 {
//                guard let data = data else {return}
//                DispatchQueue.main.async {
//                    do{
//                        let decodedResponse = try JSONDecoder().decode([AIProfile].self, from: data)
//                        self.aiProfiles = decodedResponse
//                        print("lang : \(language) \n \(self.aiProfiles)")
//                    }catch let error{
//                        print("Error decodeing: ", error)
//                    }
//                }
//            }
//        }
//        dataTask.resume()
//    }
}
