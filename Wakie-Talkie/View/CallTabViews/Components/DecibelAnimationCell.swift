//
//  DecibelAnimationCell.swift
//  Wakie-Talkie
//
//  Created by jiin on 5/19/24.
//

import Foundation
import SwiftUI

// 유저 음성 크기에 맞춰 바 크기가 움직이는 애니메이션
struct DecibelAnimationCell: View {
    @ObservedObject var audioRecorder: AudioRecordingFunc

    var body: some View {
        HStack(spacing: 5) {
            DecibelBarView(dbLevel: audioRecorder.dbLevel - 5)
            DecibelBarView(dbLevel: audioRecorder.dbLevel)
            DecibelBarView(dbLevel: audioRecorder.dbLevel - 8)
        }
        .frame(height: 50)
    }
}

struct DecibelBarView: View {
    var dbLevel: Float

    var body: some View {
        let height = max(20, CGFloat(abs(60 + dbLevel))) // 데시벨 값을 적절히 스케일링
        return RoundedRectangle(cornerRadius: 4)
            .fill( Color("Accent1"))
            .frame(width: 8, height: height)
            .animation(.easeInOut(duration: 0.1), value: height) // 애니메이션 적용
    }
}
