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
                        
                    }
                    
                    CustomButtonBig(text: "전화하러 가기", action: {
                    }, color: Color("Black"), isActive: .constant(true))
                    .frame(alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
            }
        }
        //            .navigationDestination(isPresented: $isPresentingAddAlarm){
        //                AddAlarmView(alarmList: $alarms)
    }
}

struct VocabTestView: View{
    @State var vocabDatas: [Vocab] = [
        Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
        Vocab(id: "vocab1",userId: "eunhwa813",time: Date.now, vocab: "Concurrency", meaning: "동시성"),
    ]

    var body: some View{
//        VocabView(vocabs: vocabDatas)
        VocabView(vocabs: [])
    }
}

#Preview {
    VocabTestView()
}
