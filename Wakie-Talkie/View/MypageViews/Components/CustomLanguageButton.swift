//
//  CustomLanguageButton.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/8/24.
//

import SwiftUI

struct CustomLanguageButton: View {
    var text: String
    var action: () -> Void
    @Binding var isActive: Bool
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundColor(isActive ? Color("Grey1") : Color("Black"))
                .font(.system(size: 16))
                .fontWeight(.medium)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .background(isActive ? Color("Black") : Color("Grey1"))
        .cornerRadius(10)
    }
}
struct CustomLangBtnTestView: View{
    @State private var isAvailable: Bool = false
    var body: some View{
        CustomLanguageButton(text: "영어", action: {
            if self.isAvailable {
                self.isAvailable = false
            }else{
                self.isAvailable = true
            }
        }, isActive: $isAvailable)
    }
}
    
#Preview {
    CustomLangBtnTestView()
}
