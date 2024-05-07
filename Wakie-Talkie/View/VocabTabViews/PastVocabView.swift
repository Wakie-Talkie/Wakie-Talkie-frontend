//
//  PastVocabView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct PastVocabView: View {
    @Environment(\.dismiss) var dismiss
    @State var vocabs:[Vocab]
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {dismiss()}, label: {
                    Text("<")
                        .fontWeight(.thin)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                })
                Spacer()
                Text("예전 단어장")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                Text("")
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
            }
            ScrollView {
                ForEach($vocabs){ vocab in
                    PastVocabCell(pastVocabData: vocab,numOfVocab: vocabs.count)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                }
            }
        }
    }
}

struct PastVocabTestView: View{
    @State var vocabDatas: [Vocab] = [
        Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab2",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab3",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab4",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab5",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
    ]
    @State private var int: Int = 3
    var body: some View{
        PastVocabView(vocabs: vocabDatas)
//        VocabView(vocabs: [])
    }
//    func transformToDate(dateString: String) -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy MM dd h:mm a"
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        
//        let date = dateFormatter.date(from: dateString)
//        return date!
//    }
}

#Preview {
    PastVocabTestView()
}

