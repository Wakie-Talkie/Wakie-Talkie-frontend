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
                .padding()
                .frame(minWidth: 100, minHeight: 50)
                .foregroundColor(isActive ? Color("Grey1") : Color("Black"))
                .font(.system(size: 16))
                .fontWeight(.regular)
        }
        .background(isActive ? Color("Black") : Color("Grey1"))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
