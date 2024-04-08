//
//  AlarmView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct AlarmView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("아직 알람이 없어요!")
                .font(.title)
            Spacer()
            CustomButtonBig(text: "알람 추가하기", action: {
                // 알람 추가 로직
            }, isActive: .constant(true))
            Spacer()
        }
        .navigationTitle("알람")
        .navigationBarTitleDisplayMode(.inline)
    }
}
