//
//  CustomButtonCircle.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import SwiftUI

struct CustomButtonCircle: View {
    var text: String
    var textSize: CGFloat
    var action: (() -> Void)?
    @Binding var isActive: Bool
    
    var body: some View {
        Button(action: action ?? {
            isActive = !isActive
        }) {
            Text(text)
                .frame(minWidth: 20, minHeight: 20)
                .foregroundColor(isActive ? Color("Grey1") : Color("Black"))
                .font(.system(size: textSize))
                .fontWeight(.regular)
        }
        .background(Circle().fill(isActive ? Color("Black") : Color("Grey1")))
        .cornerRadius(10)
    }
}
