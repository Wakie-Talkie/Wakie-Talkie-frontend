//
//  VocabCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct PastVocabCell: View{
    @Binding var pastVocabData: Vocab
    @Binding var numOfVocab: Int
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Accent3").opacity(0.6))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Accent3").opacity(0.6), lineWidth: 2)
                )
            VStack {
                HStack {
                    Text(extractFormattedTime(from: pastVocabData.time))
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    Spacer()
                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 3, trailing: 0))
                HStack(spacing: 15){
                    Text(pastVocabData.vocab + " 외 " + String(numOfVocab) + "개")
                        .foregroundColor(Color("Black"))
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    Spacer()
                    Text(">")
                        .foregroundColor(Color("Black"))
                        .font(.system(size: 20))
                        .fontWeight(.thin)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }.padding([.horizontal])
        }
    }
    
    func extractFormattedTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)
    }
    
}

struct PastVocabCellTestView: View{
    @State var vocab: Vocab = Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성")
    @State var numOfVocab: Int = 3
    var body: some View{
        PastVocabCell(pastVocabData: $vocab,numOfVocab: $numOfVocab)
    }
}

#Preview {
    PastVocabCellTestView()
}
