//
//  VocabView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct VocabView: View {
    @State var vocabs: [Vocab]
    @State private var isPresentingCallView = false
    @State private var isPresentingPastVocab = false
    @Binding var changeTab: Int
    //@State private var selectedAlarm: Alarm?
    var body: some View {
        NavigationStack {
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            Image("alarm_background")
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                }
                VStack() {
                    Text("단어장")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                    
                    if vocabs.isEmpty {
                        Spacer()
                        Text("전화하고 오시면 이용할 수 있어요!")
                            .foregroundColor(Color("Black"))
                            .frame(alignment: .center)
                            .font(.system(size: 25))
                            .fontWeight(.regular)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        Text("전화 내용에서 중요한 단어들을 자동으로 모아드려요")
                            .foregroundColor(Color("Black"))
                            .frame(width:300, alignment: .center)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        Spacer()
                    }else{
                        Text("가장 최근 전화에서 사용한 단어 중 중요한 단어들을 가져왔어요!")
                            .foregroundColor(Color("Black"))
                            .frame(alignment: .leading)
                            .font(.system(size: 25))
                            .fontWeight(.regular)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        Text("전화를 오래할 수록 더 많이 가져와요")
                            .foregroundColor(Color("Black"))
                            .frame(alignment: .leading)
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        
                        ScrollView {
                            ForEach($vocabs){ vocab in
                                NavigationLink(destination: VocabDetailView(vocabData: vocab)
                                ){
                                    VocabCell(vocabData: vocab)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                }
                            }
                        }
                    }
                    
                    if vocabs.isEmpty {
                        CustomButtonBig(text: "전화하러 가기", action: {
                            changeTab = 1
                        }, color: Color("Black"), isActive: .constant(true))
                        .frame(alignment: .bottom)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }else{
                        CustomButtonBig(text: "지난 단어장 보기", action: {
                            isPresentingPastVocab = true
                        }, color: Color("Black"), isActive: .constant(true))
                        .frame(alignment: .bottom)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingPastVocab){
                PastVocabView(vocabs: vocabs)
            }
//            .navigationDestination(isPresented: $isPresentingPastVocab){
//                PastVocabView(vocabs: vocabs)
//            }
        }
    }
}

struct VocabTestView: View{
    @State var vocabDatas: [Vocab] = [
        Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab2",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab3",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab4",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab5",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
    ]
    @State private var int: Int = 3
    var body: some View{
        VocabView(vocabs: vocabDatas,changeTab: $int)
//        VocabView(vocabs: [])
    }
    func transformToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateFormatter.date(from: dateString)
        return date!
    }
}

#Preview {
    VocabTestView()
}
