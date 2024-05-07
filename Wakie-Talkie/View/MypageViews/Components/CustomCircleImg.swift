//
//  CustomCircleImg.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/7/24.
//

import SwiftUI

struct CustomCircleImg: View {
    var imageUrl: String
    var showEditBtn: Bool = false
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Image(imageUrl) // 프로필 이미지 자리
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
                .shadow(radius: 3)
            if showEditBtn {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Button(action: {}){
                            Image(systemName: "pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding(EdgeInsets(top: size*0.1, leading: size*0.1, bottom: size*0.1, trailing: size*0.1))
                                .frame(width: size*0.4, height: size*0.4)
                                .foregroundColor(.black)
                                .background(Color("Main"))
                        }
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -(size*0.1), trailing: -(size*0.1)))
                    }
                }
            }
        }.frame(width: size,height: size)
    }
}

#Preview {
    CustomCircleImg(imageUrl: "ai_profile_me1", showEditBtn: true, size: 120)
}
