//
//  VocabView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/6/24.
//

import SwiftUI

struct VocabView: View {
    @State var vocabList: VocabList
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
                    
                    if vocabList.wordList.isEmpty {
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
                            ForEach(vocabList.wordList.indices ?? [].indices, id: \.self){ index in
                                let binding = $vocabList.wordList[index]
                                NavigationLink(destination: VocabDetailView(vocabData: binding)
                                ){
                                    VocabCell(vocabData: binding)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                }
                            }
                        }
                    }
                    
                    if vocabList.wordList.isEmpty {
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
//            .fullScreenCover(isPresented: $isPresentingPastVocab){
//                PastVocabView( vocabListDatas: vocabList)
////            }
            .navigationDestination(isPresented: $isPresentingPastVocab){
                PastVocabView(vocabListDatas: [vocabList])
            }
        }
    }
}

struct VocabTestView: View{
    @State var vocalList: VocabList = VocabList(id: 1, userId: 1, recordingId: 1, date: "2024-05-21", wordList: [
        Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
        Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
        Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
        Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans."),
        Vocab(word: "packed", koreanMeaning: "가득 찬", antonym: "empty", synonym: "filled", sentence: "The stadium was packed with excited fans.")
    ])
    
    @State private var int: Int = 3
    var body: some View{
        VocabView(vocabList: vocalList,changeTab: $int)
//        VocabView(vocabs: [])
    }
}

#Preview {
    VocabTestView()
}
