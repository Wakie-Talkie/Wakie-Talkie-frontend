//
//  CallRecordCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct CallRecordCell: View {
    @Binding var recordData: Recording
    @State private var isPresentRecordTextView: Bool = false
    @State private var path = NavigationPath()
    @StateObject var aiProfileData = AIProfileDataFetcher()
    @State private var language = ["ENGLISH", "KOREAN", "JAPANESE", "CHINESE"]
//    @State private var aiUserLocalData = LocalData()
//    @State private var isTextViewActive = false
    var body: some View{
        NavigationStack(path: $path) {
            HStack(spacing: 15){
                CustomCircleImg(imageUrl: aiProfileData.aiProfile?.profileImg ,showEditBtn: false, size: 70, action: {})
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                VStack(alignment: .leading){
                    Text(aiProfileData.aiProfile?.nickname ?? "failed")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                    Text(language[recordData.language - 1] + " - " + transTime(time: recordData.callingTime))
                        .fontWeight(.light)
                        .font(.system(size: 16))
                        .foregroundColor(Color("Black"))
                        .frame(alignment: .leading)
                }
                Spacer()
                 CustomButtonSmall(text: "기록보기", action: {
                     isPresentRecordTextView = true
                 }, isActive: .constant(true))
            }
            .padding(5)
            .onAppear{
    //            aiDataFetcher.getAIProfiles()
                aiProfileData.loadAiProilDataById(aiUserId: recordData.aiPartnerId)
            }
            .onChange(of: aiProfileData.aiProfile){
    //            print(aiProfileData.aiProfiles)
    //            print("profile nickname!!!! : \(aiProfileData.aiProfiles?[0].nickname)")
            }
        }
        .navigationDestination(isPresented: $isPresentRecordTextView){
            CallRecordTextView(recordId: $recordData.id, aiUserId: $recordData.aiPartnerId ,dateTime: "\(recordData.date) \(recordData.callingTime)")
        }
    }
    func transTime(time: String)-> String{
        let arr = time.components(separatedBy: ":")
        return arr[0]+"분 "+arr[1]+"초"
    }
}
