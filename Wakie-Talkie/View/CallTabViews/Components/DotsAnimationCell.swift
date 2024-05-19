//
//  DotsAnimationCell.swift
//  Wakie-Talkie
//
//  Created by jiin on 5/19/24.
//

import Foundation
import SwiftUI


// 애니메이션 뷰 예제 (점 세 개가 차례로 나타났다 사라지는 애니메이션)
struct DotsAnimationCell: View {
    @State private var showDot1: Bool = false
    @State private var showDot2: Bool = false
    @State private var showDot3: Bool = false

    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill( Color("Accent1"))
                .frame(width: 8, height: 8)
                .opacity(showDot1 ? 1 : 0)
            Circle()
                .fill( Color("Accent1"))
                .frame(width: 8, height: 8)
                .opacity(showDot2 ? 1 : 0)
            Circle()
                .fill( Color("Accent1"))
                .frame(width: 8, height: 8)
                .opacity(showDot3 ? 1 : 0)
        }
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.2)) { showDot1.toggle() }
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.4)) { showDot2.toggle() }
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.6)) { showDot3.toggle() }
    }
}
