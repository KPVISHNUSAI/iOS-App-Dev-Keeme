//
//  iOS_App_Dev_KeemeApp.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 02/02/24.
//

import SwiftUI
import SwiftData

@main
struct iOS_App_Dev_KeemeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
        .modelContainer(for: KeemeSpace.self)
    }
}
