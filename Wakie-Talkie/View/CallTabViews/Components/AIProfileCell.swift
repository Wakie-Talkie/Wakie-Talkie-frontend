//
//  AIProfileCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/25/24.
//

import SwiftUI

struct AIProfileCell: View{
    var aiData: AIProfile
    private let aiProfileDataFetcher = AIProfileDataFetcher()
    @StateObject private var audioEngine: AudioEngineFunc = AudioEngineFunc()
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Grey3").opacity(0.12))
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Stroke").opacity(0.3), lineWidth: 2)
                )
            HStack(spacing: 15){
                CustomCircleImg(imageUrl: aiData.profileImg ?? "", size: 80, shadow: 0, action: {})
//                Image(aiData.profileImg ?? "ai_profile_img")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .scaledToFill()
//                    .frame(width: 80, height: 80)
//                    .clipShape(Circle())
                
                VStack(alignment: .leading){
                    Text(aiData.nickname)
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                        .foregroundColor(Color("Black"))
                    Text(aiData.description ?? "")
                        .fontWeight(.light)
                        .font(.system(size: 16))
                        .foregroundColor(Color("Black"))
                        .frame(width:150, alignment: .leading)
                        .lineLimit(2)
                }
                Button {
                    //aiprofile의 설명을 예시로 읽어주는 function -> 그냥 AIProfileDB에 예시 음성 파일 박아두면 될듯?
                    print("Button clicked!!!!!! \(aiData.id)")
                    aiProfileDataFetcher.getAiSampleAudio(aiUserId: aiData.id){
                        result in
                        print("get sample audio")
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let responseURL):
                                DispatchQueue.main.async {
                                    print("response url!!!!!! \(responseURL)")
                                    audioEngine.audioPlay(from: responseURL)
                                }
                            case .failure(let error):
                                print("Upload failed: \(error)")
                            }
                        }
                    }
                }label: {
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundColor(Color("Black"))
                        .font(.system(size: 20))
                }
            }
        }
        .padding([.horizontal])
    }
}

struct AICellTestView: View{
    @State var aiProfile: AIProfile = AIProfile(id: 1, nickname: "Alexis",profileImg: "AIProfileImg",aiType: "openai", description: "I like watching animation and go out for a walk.", language: 1)
    var body: some View{
        AIProfileCell(aiData: aiProfile)
    }
}

//#Preview {
//    AICellTestView()
//}
