//
//  VocabDataFetcher.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import Combine
import Foundation

class VocabDataFetcher: ObservableObject {
    @Published var vocabListDatas: [VocabList]?
    @Published var vocabListData: VocabList?
    
    func loadVocabListDatas() {
        getVocabListDatas { [weak self] vocabListDatas in
            DispatchQueue.main.async {
                self?.vocabListDatas = vocabListDatas
            }
        }
    }
    
    func loadRecentVocabListData(userID: Int) {
        getRecentVocabListDatas(userID: userID) { [weak self] vocabListData in
            DispatchQueue.main.async {
                self?.vocabListData = vocabListData
                print(vocabListData)
            }
        }
    }
    
    
    func getVocabListDatas(completion: @escaping ([VocabList]) -> Void){
        HTTPManager.requestGET(url:
        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/vocab-lists/"
//           "http://127.0.0.1:8000/vocab-lists/recent/"
        ) { data in
            guard let data: [VocabList] = JSONConverter.decodeVocabListJsonArray(data: data) else {return}
            print(data)
            completion(data)
        }
    }
    
    func getRecentVocabListDatas(userID: Int, completion: @escaping (VocabList) -> Void){
        HTTPManager.requestGET(url:
        "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/vocab-lists/recent/\(userID)"
//                               "http://127.0.0.1:8000/vocab-lists/recent/\(userID)"
        ) { data in
//            guard let data: VocabList = JSONConverter.decodeJson(data: data) else {return}
            guard let data: VocabList = JSONConverter.decodeVocabListJson(data: data) else {return}
            print(data)
            completion(data)
        }
    }
}
