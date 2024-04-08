//
//  CustomButtonBig.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct CustomButtonBig: View {
    var text: String
    var action: () -> Void
    @Binding var isActive: Bool
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .background(isActive ? Color.blue : Color.gray)
        .cornerRadius(10)
        .padding(.horizontal)
        .disabled(!isActive)
    }
}
