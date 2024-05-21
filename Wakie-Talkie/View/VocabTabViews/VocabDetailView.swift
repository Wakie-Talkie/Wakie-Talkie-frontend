//
//  VocabDetailView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct VocabDetailView: View {
    @Binding var vocabData: Vocab
    var body: some View {
        Text(vocabData.word)
        Text(vocabData.koreanMeaning)
    }
}

struct VocabDetailTestView:View{
    @State private var vocab: Vocab = Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
    var body: some View{
        VocabDetailView(vocabData: $vocab)
    }
}
#Preview {
    VocabDetailTestView()
}
