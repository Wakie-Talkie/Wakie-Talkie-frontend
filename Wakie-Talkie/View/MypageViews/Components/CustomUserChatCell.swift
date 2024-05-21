//
//  CustomUserChatCell.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/21/24.
//

import SwiftUI

struct CustomUserChatCell: View {
    var text: String
    var body: some View {
        Text(text)
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .background(Color.white)
    }
}

#Preview {
    CustomUserChatCell(text: "Lorem ipsum dolor sit amet consectetur. Ut maecenas tristique sed elit purus fermentum accumsan rutrum amet.")
}
