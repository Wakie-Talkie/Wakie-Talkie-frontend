//
//  CustomProgressViewStyle.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 5/22/24.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    var mainColor: Color
    var strokeColor: Color
    var strokeWidth: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: strokeWidth / 2)
                .fill(strokeColor)
                .frame(height: strokeWidth)
            RoundedRectangle(cornerRadius: strokeWidth / 2)
                .fill(mainColor)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * UIScreen.main.bounds.width * 0.8, height: strokeWidth)
        }
    }
}
