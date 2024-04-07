////
////  AlarmAddedView.swift
////  Wakie-Talkie
////
////  Created by 이은화 on 2024/04/04.
////
//
//import SwiftUI
//
//var alramDataList : [AlarmDataModel] = [
//    AlarmDataModel.init(time: "오후 6:00", language: "ENGLISH", weeklyRepeat: nil, isOn: false),
//    AlarmDataModel.init(time: "오전 9:00", language: "ENGLISH", weeklyRepeat: [false,false,true,false,false,false,false], isOn: true),
//    AlarmDataModel.init(time: "오전 12:00", language: "KOREAN", weeklyRepeat: nil, isOn: true),
//]
//struct AlarmAddedView: View {
//    @Binding var alarmList: [AlarmDataModel]
//    var body: some View {
//        ZStack {
//            Image("alarm_background")
//                .position(CGPoint(x: 262, y: 360))
//                .ignoresSafeArea(.container, edges: .top)
//            VStack (spacing: 40){
//                List(alarmList, id: \.self){ alarm in
//                    AlarmCellView(alarmData: alarm)
//                }
//                Group {
//                    Button(action: {
//                        
//                    }, label: {
//                        VStack {
//                            Text("알림 추가하기")
//                                .font(.title3)
//                                .padding(.horizontal,8)
//                                .frame(minWidth: 350,maxHeight: 70)
//                                .fontWeight(.bold)
//                                .foregroundStyle(Color(hexString: "FFFFFF"))
//                                .background((Color(hexString: "08121B")))
//                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
//                            Rectangle()
//                                .frame(height: 50)
//                                .foregroundStyle(.clear)
//                                .background(.clear)
//                        }
//                    })
//                }.frame(maxHeight: .infinity, alignment: .bottom)
//            }
//        }
//    }
//}
//
//#Preview {
//    //AlarmAddedView(alarmList: alramDataList)
//} as! any View
