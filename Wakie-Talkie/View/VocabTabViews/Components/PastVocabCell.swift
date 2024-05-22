//
//  VocabCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct PastVocabCell: View{
    @Binding var pastVocabData: Vocab
    var numOfVocab: Int
    var date: String
    var body: some View{
//        ZStack{
            
            HStack{
                VStack {
                    HStack {
                        Text(date)
                            .foregroundColor(Color("Black"))
                            .font(.system(size: 16))
                            .fontWeight(.thin)
                            .padding(EdgeInsets(top: 15, leading: 25, bottom: 5, trailing: 0))
                        Spacer()
                    }
                    HStack(alignment: .bottom, spacing: 15){
                        Text(pastVocabData.word)
                            .foregroundColor(Color("Black"))
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 0, leading: 25, bottom: 20, trailing: 0))
                        Text("외 " + String(numOfVocab) + "개")
                            .foregroundColor(Color("Black"))
                            .font(.system(size: 22))
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 0, leading: -5, bottom: 20, trailing: 0))
                        Spacer()
                    }
                }
                Spacer()
                Text(">")
                    .foregroundColor(Color("Black"))
                    .font(.system(size: 20))
                    .fontWeight(.thin)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color("Accent3").opacity(0.6))
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Accent3").opacity(0.6), lineWidth: 2)
                ))
        
//        }
    }
}

struct PastVocabCellTestView: View{
    @State var vocab: Vocab = Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
    @State var num: Int = 4
    @State var dateStr: String = "2024-05-22"
    var body: some View{
        PastVocabCell(pastVocabData: $vocab,numOfVocab: num,date: dateStr)
    }
}

#Preview {
    PastVocabCellTestView()
}
