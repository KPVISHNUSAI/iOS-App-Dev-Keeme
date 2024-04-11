//
//  iOS_App_Dev_KeemeApp.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 02/02/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import GoogleSignInSwift


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth()
//        Auth.auth().useEmulator(withHost:"localhost", port:9099)
//        let settings = Firestore.firestore().settings
//        settings.host = "127.0.0.1:8080"
//        settings.cacheSettings = MemoryCacheSettings()
//        settings.isSSLEnabled = false
//        Firestore.firestore().settings = settings
        return true
    }
}


@main
struct iOS_App_Dev_KeemeApp: App {
    @State var showSignInView = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(showSignInView: $showSignInView)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    
                    
                ScheduleView(showSignInView: $showSignInView)
                    .tabItem { Label("Schedule", systemImage: "calendar") }
                
//                FavouritesView(showSignInView: $showSignInView)
//                    .tabItem { Label("Favourites", systemImage: "star") }
                    
                SettingsView(showSignInView: $showSignInView)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .background(Color.purple)
            }.accentColor(.purpleSet)
                
            .onAppear {
                UITabBar.appearance().barTintColor = UIColor.white // Set the background color of the tab bar
            }
        }
    }
}
