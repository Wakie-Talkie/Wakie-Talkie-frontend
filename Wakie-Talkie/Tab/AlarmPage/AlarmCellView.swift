////
////  AlarmCellView.swift
////  Wakie-Talkie
////
////  Created by 이은화 on 2024/04/04.
////
//
//import SwiftUI
//
//struct AlarmCellView: View {
//    @State private var toggleIsOn: Bool = false
//    var alramData: AlarmDataModel = AlarmDataModel.init(time: "오전 9:00", language: "ENGLISH", weeklyRepeat: [false,false,true,false,true,false,false], isOn: true)
//    var weekData: [String] = ["월","화","수","목","금","토","일"]
//    var body: some View {
//        ZStack{
//            RoundedRectangle(cornerRadius: 10.0)
//                .frame(width: 350,height: 150)
//                .background(.clear)
//                .foregroundColor(Color(hexString: "DFE0E1", opacity: 0.12))
//            
//            VStack (alignment: .leading,spacing: 5){
//                Rectangle()
//                    .frame(width:350,height: 2)
//                    .background(.clear)
//                    .foregroundColor(.clear)
//                Text("언어: \(alarmData.language)")
//                    .font(.system(size: 16, weight: .light))
//                    .padding(EdgeInsets(top: 0, leading: 23, bottom: 0, trailing: 0))
//                Text(alarmData.time)
//                    .font(.system(size: 45, weight: .light))
//                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
//                HStack(spacing: 5) {
//                    Rectangle()
//                        .frame(width:15,height: 2)
//                        .background(.clear)
//                        .foregroundColor(.clear)
//                    ForEach(0..<7, id: \.self) {index in
//                        Button(action: {
//                            alarmData.weeklyRepeat[index] = !alarmData.weeklyRepeat[index]
//                        } ,label: {
//                            Text(weekData[index])
//                                .foregroundColor(alarmData.weeklyRepeat[index] ? .white : .black)
//                                .font(.system(size: 12, weight: .thin))
//                                .frame(maxWidth: 25, maxHeight: 25)
//                                .background(alarmData.weeklyRepeat[index] ? Color(hexString: "08121B") : Color(hexString: "EDEFF1"))
//                                .cornerRadius(15)
//                        })
//                    }
//                    Rectangle()
//                        .frame(width:45,height: 2)
//                        .background(.clear)
//                        .foregroundColor(.clear)
//                    Toggle("alarm On Off", isOn: $toggleIsOn)
//                        .labelsHidden()
//                        .tint(Color(hexString: "08121B"))
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    //AlarmCellView()
//}
