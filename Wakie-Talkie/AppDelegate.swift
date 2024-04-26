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
    
    // 앱이 종료될 예정일 때 호출됩니다. 하지만 강제 종료된 경우 호출되지 않을 수 있습니다.
    func applicationWillTerminate(_ application: UIApplication) {
        // UNUserNotificationCenter 인스턴스 생성
        let center = UNUserNotificationCenter.current()
        print("방금앱끔!!!!!")

        // 알림 내용 설정
        let content = UNMutableNotificationContent()
        content.title = "끄면 안돼!"
        content.body = "그럼 너 알람 못들어!"
        content.sound = UNNotificationSound.default

        // 알림 트리거 설정 (즉시 알림을 위해 nil)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // 알림 센터에 알림 요청 추가
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
        
    }
}
