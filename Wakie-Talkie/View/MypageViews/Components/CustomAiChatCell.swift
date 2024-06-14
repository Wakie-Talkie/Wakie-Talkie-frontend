//
//  CustomAiChatCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import SwiftUI

struct CustomAiChatCell: View {
    var imgUrl: String?
    var text: String
    
    var body: some View {
        HStack{
            CustomCircleImg(imageUrl: imgUrl,showEditBtn: false, size: 60, action: {})
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 15))
            Text(text)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 30))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .background(Color.clear)
    }
}

#Preview {
    CustomAiChatCell(imgUrl: "ai_profile_me1", text: "Lorem ipsum dolor sit amet consectetur. Volutpat placerat vitae sit volutpat vehicula turpis lobortis. Pellentesque pulvinar sodales in at eleifend sed hac mattis.")
}
