//
//  AppDelegate.swift
//  Wakie-Talkie
//
//  Created by jiin on 4/26/24.
//
import UIKit
import UserNotifications


class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 알림 권한 요청
        let center = UNUserNotificationCenter.current()
        center.delegate = self  // 알림을 처리할 델리게이트 설정
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("알림 허용됨")
            } else {
                print("알림 거부됨")
            }
        }
        return true
    }
    
    // 앱이 포그라운드에 있을 때 알림이 도착하면 호출됩니다.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound]) // iOS 14 이상의 옵션
    }
    
    // 사용자가 알림을 탭했을 때 호출됩니다.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 알림에 반응할 때 수행할 동작을 여기에 추가합니다.
        completionHandler()
    }
}
