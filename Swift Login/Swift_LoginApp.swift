//
//  Swift_LoginApp.swift
//  Swift Login
//
//  Created by Sumesh Vs on 01/07/21.
//

import SwiftUI
import Firebase

@main
struct Swift_LoginApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
            Tabbar()
                .environmentObject(authentication)
            } else {
                LoginView()
                .environmentObject(authentication)
            }
        }
    }
    
    // for Firebase we injecting didfinishlaunchingWithOption method
    class AppDelegate : NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
    }
    
}
