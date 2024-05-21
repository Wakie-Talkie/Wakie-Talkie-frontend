//
//  VocabDetailCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import SwiftUI

struct VocabDetailCell: View {
    @Binding var vocabData: Vocab
    var body: some View {
        VStack{
            //work : koreanMeaning
            HStack(alignment: .bottom) {
                Text(vocabData.word)
                    .font(.system(size: 30))
                    .fontWeight(.regular)
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 5))
                Text(": \(vocabData.koreanMeaning)")
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Spacer()
            }
            HStack{
                Text("유: \(vocabData.synonym)")
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("Accent3")))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                Text("반: \(vocabData.antonym)")
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("Black")))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                Spacer()
            }
            HStack {
                Text("예문: \(vocabData.sentence)")
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 10))
                Spacer()
            }
        }
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(Color("Grey1"))
            .frame(maxWidth: .infinity))
    }
}
struct VocabDetailCellTestView: View{
    @State var vocab: Vocab = Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
    
    var body: some View{
        VocabDetailCell(vocabData: $vocab)
    }
}

#Preview {
    VocabDetailCellTestView()
}
