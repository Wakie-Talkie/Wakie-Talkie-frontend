//
//  VocabDetailListView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/22/24.
//

import SwiftUI

struct VocabDetailListView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var vocabListData: VocabList
    var body: some View {
        VStack{
            HStack {
                Button(action: {dismiss()}, label: {
                    Image("back_btn")
                })
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                Spacer()
                Text("단어")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                Text("")
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
            }
            ScrollView{
                ForEach(vocabListData.wordList.indices ?? [].indices, id: \.self) {index in
                    VocabDetailCell(vocabData: $vocabListData.wordList[index])
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

