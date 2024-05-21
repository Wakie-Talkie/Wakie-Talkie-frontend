//
//  PastVocabView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct PastVocabView: View {
    @Environment(\.dismiss) var dismiss
    @State var vocabListDatas: [VocabList]
    
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
                ForEach($vocabListDatas){ vocab in
                    PastVocabCell(pastVocabData: vocab.wordList[0],numOfVocab: vocab.wordList.count, date: "2024-05-21")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                }
            }
        }
    }
}
//
//struct PastVocabTestView: View{
//    @State var vocabListDatas: [VocabList] = [
//        VocabList(id: 1, userId: 1, recordingId: 1, date: "2024-05-21", wordList: [
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
//        ]),
//        VocabList(id: 1, userId: 1, recordingId: 1, date: "2024-05-21", wordList: [
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
//        ]),
//        VocabList(id: 1, userId: 1, recordingId: 1, date: "2024-05-21", wordList: [
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
//        ]),
//        VocabList(id: 1, userId: 1, recordingId: 1, date: "2024-05-21", wordList: [
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
//            Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
//        ])
//    ]
//    @State private var int: Int = 3
//    var body: some View{
//        PastVocabView(vocabListDatas: vocabListDatas)
////        VocabView(vocabs: [])
//    }
////    func transformToDate(dateString: String) -> Date {
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy MM dd h:mm a"
////        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
////        
////        let date = dateFormatter.date(from: dateString)
////        return date!
////    }
//}
//
//#Preview {
//    PastVocabTestView()
//}

