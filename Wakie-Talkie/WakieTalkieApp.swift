//
//  WakieTalkieApp.swift
//  Wakie-Talkie
//
//  Created by 이은화 on 4/10/24.
//

import Amplify
import Authenticator
import AWSCognitoAuthPlugin
import SwiftUI

@main
struct WakieTalkieApp: App {
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
        } catch {
            print("Unable to configure Amplify \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup{
            Authenticator(
                signInContent: { state in
                    HStack {
                        Image("custom_image")
                        Divider()
                        LoginView(state: state)
                    }
                }
            )
           { state in
                            VStack {
                                MainTabView()
//                                Text("Hello, \(state.user.username)")
//                                Text(state.user.userId)
//                                
//                                Button("Sign out") {
//                                    Task {
//                                        await state.signOut()
//                                    }
//                                }
                            }
                        }
            //MainTabView()
        }
    }
}

