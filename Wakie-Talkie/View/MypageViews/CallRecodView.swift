//
//  CallRecodView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct CallRecodView: View {
    @Environment(\.dismiss) var dismiss
    //    @State var recordList: [Recording] = []
    @State private var lastDate:String = ""
    
    @ObservedObject var recordData = RecordingDataFetcher()
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {dismiss()}, label: {
                    Text("<")
                        .fontWeight(.thin)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Black"))
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 0))
                })
                Spacer()
                Text("통화 기록")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                Text("")
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 30))
            }
            ScrollView{
                ForEach(recordData.records.indices ?? [].indices, id: \.self) { index in
                    let binding = $recordData.records[index]
                    VStack{
                        if (index == 0)||((index != 0)&&(binding.date.wrappedValue != $recordData.records[index-1].date.wrappedValue)) {
                            HStack {
                                Text(binding.date.wrappedValue)
                                    .fontWeight(.medium)
                                .font(.system(size: 18))
                                .padding(EdgeInsets(top: 20, leading: 25, bottom: 0, trailing: 0))
                                Spacer()
                            }
                        }
                        CallRecordCell(recordData: binding)
                    }
                }
            }
        }
        .onAppear(perform: {
            recordData.loadRecordData()}
        )
        .onChange(of: recordData.records){
            print(recordData.records)
            print("profile nickname!!!! : \(recordData.records[0].id)")
        }
        .navigationBarBackButtonHidden(true)
    }
}
