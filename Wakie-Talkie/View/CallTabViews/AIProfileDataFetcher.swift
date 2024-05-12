//
//  File.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import Combine
import Foundation

class AIProfileDataFetcher: ObservableObject {
//    @Published var aiProfiles: [AIProfile]?
    @Published var aiProfiles: [AIProfile]?
    
    func loadAiProfileData() {
        getAiProfileData { [weak self] aiProfilesData in
            DispatchQueue.main.async {
                self?.aiProfiles = aiProfilesData
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
       }
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
    func loadAiProfileDataFromLang(language: Int) {
        getAiProfileDataFromLang(language: language) { [weak self] aiProfilesData in
            DispatchQueue.main.async {
                self?.aiProfiles = aiProfilesData
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
        }
    }
    
    func getAiProfileData(completion: @escaping ([AIProfile]) -> Void){
        HTTPManager.requestGET(url: "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/") { data in
            guard let data: [AIProfile] = JSONConverter.decodeJsonArray(data: data) else { return
            }
            completion(data)
        }
    }
    
    func getAiProfileDataFromLang(language: Int, completion: @escaping ([AIProfile]) -> Void){
        HTTPManager.requestGET(url: "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/language/\(language)/") { data in
            guard let data: [AIProfile] = JSONConverter.decodeJsonArray(data: data) else { return
            }
            completion(data)
        }
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
