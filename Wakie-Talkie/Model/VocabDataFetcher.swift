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
    
    func fetchVocabs(){
        let fetchVocabs = [
            Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
            Vocab(id: "vocab2",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
            Vocab(id: "vocab3",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
            Vocab(id: "vocab4",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
            Vocab(id: "vocab5",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        ]
        self.vocabs = fetchVocabs
    }
    func transformToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}
