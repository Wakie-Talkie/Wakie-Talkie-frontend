//
//  CustomButtonSmall.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import SwiftUI

struct CustomButtonSmall: View {
    var text: String
    var action: () -> Void
    @Binding var isActive: Bool
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundColor(isActive ? Color("Grey1") : Color("Black"))
                .font(.system(size: 14))
                .fontWeight(.regular)
        }
        .background(isActive ? Color("Black") : Color("Grey1"))
        .cornerRadius(10)
    }
}
