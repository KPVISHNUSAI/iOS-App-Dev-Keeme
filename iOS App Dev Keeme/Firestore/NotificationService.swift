////
////  NotificationService.swift
////  iOS App Dev Keeme
////
////  Created by user2 on 01/04/24.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//
//struct NotificationService {
//    static func sendNotification(to userId: String, message: String) async throws {
//        // Fetch the device token of the user from your backend database
//        guard let deviceToken = try await fetchDeviceToken(for: userId) else {
//            // Handle the case where the device token is not available
//            return
//        }
//        
//        // Configure the notification content
//        let content = UNMutableNotificationContent()
//        content.title = "Keemespace Notification"
//        content.body = message
//        
//        // Create the notification request
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
//        
//        // Send the notification request to the user's device using FCM
//        let messaging = Messaging.messaging()
//        messaging.apnsToken = deviceToken.data(using: .utf8)
//        messaging.delegate = self // Optional: Handle callbacks if needed
//        messaging.send(request) { error in
//            if let error = error {
//                print("Error sending notification: \(error.localizedDescription)")
//            } else {
//                print("Notification sent successfully!")
//            }
//        }
//    }
//    
//    
//    static func fetchDeviceToken(for userId: String) async throws -> String? {
//        // Reference to the Firestore collection containing user data
//        let userCollection = Firestore.firestore().collection("users")
//        
//        do {
//            // Query Firestore to fetch the document corresponding to the user
//            let userDoc = try await userCollection.document(userId).getDocument()
//            
//            // Check if the document exists and contains a device token field
//            if let userData = userDoc.data(),
//               let deviceToken = userData["deviceToken"] as? String {
//                return deviceToken // Return the device token
//            } else {
//                return nil // Device token not found or user document doesn't exist
//            }
//        } catch {
//            throw error // Propagate any errors that occur during Firestore operation
//        }
//    }
//}
