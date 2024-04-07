//
//  AlarmView.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 2024/04/04.
//

import SwiftUI

struct AlarmView: View {
    var body: some View {
        ZStack {
            Image("alarm_background")
                .position(CGPoint(x: 262, y: 360))
                .ignoresSafeArea(.container, edges: .top)
            VStack (spacing: 40){
                Text("아직 알람이 없어요!")
                    .font(.title)
                Button{
                    
                } label: {
                    Text("알림 추가하기")
                        .font(.title3)
                        .padding(.horizontal,8)
                        .frame(minWidth: 350,maxHeight: 70)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(hexString: "FFFFFF"))
                        .background((Color(hexString: "08121B")))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
            }
        }
    }
}

#Preview {
    AlarmView()
}
