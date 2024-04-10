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
    var color: Color
    @Binding var isActive: Bool
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, minHeight: 35)
                .padding()
        }
        .background(color)
        .cornerRadius(10)
        .padding(.horizontal)
        .disabled(!isActive)
    }
}
