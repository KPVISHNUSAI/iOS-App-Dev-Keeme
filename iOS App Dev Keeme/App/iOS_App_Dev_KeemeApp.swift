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
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
//        .modelContainer(for: User.self)
//        .modelContainer(for: KeemeSpace.self)
        
        
    }

//    init() {
//        let schema = Schema([Student.self,Meeting.self,
//                             StudentMeeting.self,
//                             FavoriteStudents.self,
//                             FavoriteMeetings.self])
//        let config = ModelConfiguration("Student", schema: schema)
//        do {
//            container = try ModelContainer(for: schema, configurations: config)
//        } catch {
//            fatalError("Could not configure the container")
//        }
//        
//        print(URL.applicationSupportDirectory.path(percentEncoded: false))
//    }
    
    init() {
        let schema = Schema([Student.self, Meeting.self, StudentMeeting.self, FavoriteStudents.self, FavoriteMeetings.self])
        let config = ModelConfiguration("KeemeApp",schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }

}
