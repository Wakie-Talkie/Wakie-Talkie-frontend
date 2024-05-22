//
//  PastVocabView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct PastVocabView: View {
    @Environment(\.dismiss) var dismiss
    @State private var vocabListDatas: [VocabList] = []
    @StateObject var vocabList = VocabDataFetcher()
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {dismiss()}, label: {
                    Image("back_btn")
                })
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
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
                    NavigationLink(destination: VocabDetailListView(vocabListData: vocab)
                    ){
                        PastVocabCell(pastVocabData: vocab.wordList[0],numOfVocab: (vocab.wordList.count - 1), date: vocab.date.wrappedValue)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    }
                }
            }
        }
        .onAppear(perform: {
            vocabList.loadVocabListDatas()
        })
        .onChange(of: vocabList.vocabListDatas){
            vocabListDatas = vocabList.vocabListDatas ?? []
            print(vocabListDatas)
        }
        .navigationBarBackButtonHidden(true)
    }
}
