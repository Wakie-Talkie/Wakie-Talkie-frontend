//
//  CallView.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/8/24.
//

import SwiftUI

struct CallView: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer()
                        Image("alarm_background")
                            .edgesIgnoringSafeArea(.all)
                    }
                }
            }
        }
    }
}

#Preview {
    CallView()
}
