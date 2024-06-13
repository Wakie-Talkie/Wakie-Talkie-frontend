//
//  UserDataFetcher.swift
//  Wakie-Talkie
//
//  Created by jiin on 5/12/24.
//

import Foundation


final class UserDataFetcher: ObservableObject {
    @Published var user: User?

    func loadUserData() {
        getUserData { [weak self] userData in
            DispatchQueue.main.async {
                self?.user = userData
                // 여기에서 UI 업데이트를 트리거할 수 있습니다.
                // 예: NotificationCenter를 사용하거나, SwiftUI에서는 @Published 프로퍼티를 업데이트할 수 있습니다.
            }
        }
    }

    func getUserData(completion: @escaping (User) -> Void){
        HTTPManager.requestGET(url: "http://localhost:8000/users/1/"
//                                "http://ec2-3-37-108-96.ap-northeast-2.compute.amazonaws.com:8000/users/1/"
        ) { data in
            guard let data: User = JSONConverter.decodeJson(data: data) else {
                print("nooo")
                return
            }
            completion(data)
        }
    }
}
