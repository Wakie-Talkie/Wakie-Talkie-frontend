//
//  VocabDetailView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct VocabDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var vocabData: Vocab
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
            VocabDetailCell(vocabData: $vocabData)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct VocabDetailTestView:View{
    @State private var vocab: Vocab
//    = Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
    var body: some View{
        VocabDetailView(vocabData: $vocab)
    }
}
//#Preview {
//    VocabDetailTestView()
//}
