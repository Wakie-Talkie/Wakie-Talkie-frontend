//
//  VocabDataFetcher.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import Combine
import Foundation

class VocabDataFetcher: ObservableObject {
    @Published var vocabs: [Vocab]?
//    func getAiProfileData(completion: @escaping ([Vocab]) -> Void){
//
//        HTTPManager.requestGET(url:
//        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/ai-users/"
//
//        ) { data in
//            guard let data: [AIProfile] = JSONConverter.decodeJsonArray(data: data) else { return
//            }
//            completion(data)
//        }
//    }
}
