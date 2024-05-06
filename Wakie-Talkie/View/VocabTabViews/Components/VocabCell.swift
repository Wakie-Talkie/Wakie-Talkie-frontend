//
//  VocabCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct VocabCell: View{
    @Binding var vocabData: Vocab
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Accent3").opacity(0.1))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Accent3").opacity(0.3), lineWidth: 2)
                )
            HStack(spacing: 15){
                Text(vocabData.vocab)
                    .foregroundColor(Color("Black"))
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                Spacer()
                Text("뜻 보기 >")
                    .foregroundColor(Color("Black"))
                    .font(.system(size: 16))
                    .fontWeight(.thin)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
            }
        }
        .padding([.horizontal])
    }
}

struct VocabCellTestView: View{
    @State var vocab: Vocab = Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성")
    var body: some View{
        VocabCell(vocabData: $vocab)
    }
}

#Preview {
    VocabCellTestView()
}
