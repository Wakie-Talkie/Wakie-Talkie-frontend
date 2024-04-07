////
////  AlarmData.swift
////  Wakie-Talkie
////
////  Created by 이은화 on 2024/04/04.
////
//
//import Foundation
//import SwiftUI
//
//struct AlarmDataModel {
//    var time: String
//    var language: String
//    var weeklyRepeat: Array<Bool>
//    var isOn: Bool
//    //var aiProfile: String
////    
//    init(time: String, language: String, weeklyRepeat: Array<Bool>?, isOn: Bool){
//        self.time = time
//        self.language = language
//        self.weeklyRepeat = (weeklyRepeat == nil ? [false,false,false,false,false,false,false] : weeklyRepeat!)
//        self.isOn = isOn
//        //self.aiProfile = aiProfile
//    }
//}
//var AlramDataList : [AlarmDataModel] = [
//    AlarmDataModel.init(time: "오후 6:00", language: "ENGLISH", weeklyRepeat: [false,false,false,false,false,false,false], isOn: false),
//    AlarmDataModel.init(time: "오전 9:00", language: "ENGLISH", weeklyRepeat: [false,false,true,false,false,false,false], isOn: true),
//    AlarmDataModel.init(time: "오전 12:00", language: "KOREAN", weeklyRepeat: [false,false,true,false,false,false,true], isOn: true),
//]
