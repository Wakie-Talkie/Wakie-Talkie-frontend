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
        Text(vocabData.vocab)
        Text(vocabData.meaning)
    }
}

struct VocabDetailTestView:View{
    @State private var vocab: Vocab = Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성")
    var body: some View{
        VocabDetailView(vocabData: $vocab)
    }
}
#Preview {
    VocabDetailTestView()
}
