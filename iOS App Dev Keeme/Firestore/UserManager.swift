//
//  FirestoreViewModel.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 24/03/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage

struct DBUser: Codable {
    let userId: String
    let firstName: String?
    let lastName: String?
    let isAnonymous: Bool?
    let email: String?
    let photoUrl : String?
    let dateCreated: Date?
    let isPremium: Bool?
    let interests: [String]?
    let favourites: [String]?
    
    init(auth: AuthDataResultModel){
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
        self.interests = nil
        self.firstName = auth.firstName
        self.lastName = auth.lastName
        self.favourites = nil
    }
    
    init(
        userId: String,
        isAnonymous: Bool? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        email: String? = nil,
        photoUrl : String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil,
        interests: [String]? = nil,
        favourites: [String]? = nil
    ){
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
        self.interests = interests
        self.firstName = firstName
        self.lastName = lastName
        self.favourites = favourites
    }
    
    //    func togglePremiumStatus() -> DBUser {
    //        let currentValue = isPremium ?? false
    //        return DBUser(
    //            userId: userId,
    //            isAnonymous: isAnonymous,
    //            email: email,
    //            photoUrl: photoUrl,
    //            dateCreated: dateCreated,
    //            isPremium: !currentValue,
    //            interests: interests
    //        )
    //    }
    
    //    mutating func togglePremiumStatus() {
    //        let currentValue = isPremium ?? false
    //        isPremium = !currentValue
    //    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "user_isPremium"
        case interests = "interests"
        case firstName = "firstName"
        case lastName = "lastName"
        case favourites = "favourites"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.interests = try container.decodeIfPresent([String].self, forKey: .interests) // Decode interests array
        self.favourites = try container.decodeIfPresent([String].self, forKey: .favourites) // Decode favourites array
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.lastName, forKey: .lastName)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.interests, forKey: .interests) // Encode interests array
        try container.encodeIfPresent(self.favourites, forKey: .favourites) // Encode favourites array
    }
}




final class UserManager {
    
    static let shared = UserManager()
    private init(){ }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func getCurrentUser() async throws -> DBUser? {
        if let currentUser = Auth.auth().currentUser {
            // User is currently authenticated
            // You can fetch the user details from Firestore based on the currentUser.uid
            // Here's a basic example assuming you have a Firestore document for each user
            do {
                let documentSnapshot = try await userDocument(userId: currentUser.uid).getDocument()
                if let userData = documentSnapshot.data() {
                    // Parse userData to create a DBUser object
                    // Example:
                    let user = DBUser(
                        userId: currentUser.uid,
                        firstName: userData["firstName"] as? String,
                        lastName: userData["lastName"] as? String
                        // Parse other user data fields
                    )
                    return user
                } else {
                    // User document not found
                    return nil
                }
            } catch {
                // Error fetching user document
                throw error
            }
        } else {
            // No user logged in
            return nil
        }
    }
    
    //    private let encoder: Firestore.Encoder = {
    //        let encoder = Firestore.Encoder()
    //        encoder.keyEncodingStrategy = .convertToSnakeCase
    //        return encoder
    //    }()
    //
    //    private let decoder: Firestore.Decoder = {
    //        let decoder = Firestore.Decoder()
    //        decoder.keyDecodingStrategy = .convertFromSnakeCase
    //        return decoder
    //    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    //    func createNewUser(auth: AuthDataResultModel) async throws {
    //        var userData: [String: Any] = [
    //            "user_id": auth.uid,
    //            "is_anonymous": auth.isAnonymous,
    //            "date_created": Timestamp(),
    //        ]
    //
    //        if let email = auth.email {
    //            userData["email"] = email
    //        }
    //
    //        if let photoUrl = auth.photoUrl {
    //            userData["photo_url"] = photoUrl
    //        }
    //
    //        try await userDocument(userId: auth.uid).setData(userData, merge: false)
    //    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    //    func getUser(userId: String) async throws -> DBUser {
    //        let snapshot = try await userDocument(userId: userId).getDocument()
    //        guard let data = snapshot.data() else {
    //            throw URLError(.badServerResponse)
    //        }
    //
    //        let isAnonymous = data["is_anonymous"] as? Bool
    //        let email = data["email"] as? String
    //        let photoUrl = data["photo_url"] as? String
    //        let dateCreated = data["date_created"] as? Date
    //
    //        return DBUser(userId: userId, isAnonymous: isAnonymous, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
    //    }
    
    //    func updateUserPremiumStatus(user: DBUser) async throws {
    //        try userDocument(userId: user.userId).setData(from: user, merge: true)
    //    }
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    
    func addUserIntrests(userId: String, interest: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.interests.rawValue: FieldValue.arrayUnion([interest])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func removeUserIntrests(userId: String, interest: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.interests.rawValue: FieldValue.arrayRemove([interest])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    // Mark
    
    func addToFavouriteUsers(userId: String, favoriteUserId: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.favourites.rawValue: FieldValue.arrayUnion([favoriteUserId])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
     
    func getAllFavorites(userId: String) async throws -> [DBUser] {
            let userDocument = userCollection.document(userId)
            let documentSnapshot = try await userDocument.getDocument()
            if let data = documentSnapshot.data(),
               let favorites = data["favourites"] as? [String] {
                // Fetch DBUser objects for each favorite user ID
                let users = try await fetchUsers(for: favorites)
                return users
            } else {
                return []
            }
        }
    
    private func fetchUsers(for userIds: [String]) async throws -> [DBUser] {
            var users: [DBUser] = []
            for userId in userIds {
                let user = try await getUser(userId: userId)
                users.append(user)
            }
            return users
        }
    
    func updateUserPhotoUrl(userId: String, photoUrl: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.photoUrl.rawValue: photoUrl
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func uploadImageAndGetURL(image: UIImage, completion: @escaping (URL) -> Void) {
        // Reference to the Firebase Storage bucket where you want to upload the image
        let storageRef = Storage.storage().reference().child("profile_images").child("\(UUID().uuidString).jpg")
        
        // Convert UIImage to Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert UIImage to Data")
            return
        }
        
        // Upload image data to Firebase Storage
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                print("Error uploading image:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            // Image uploaded successfully, get download URL
            storageRef.downloadURL { url, error in
                if let downloadURL = url {
                    completion(downloadURL) // Pass the download URL to the completion handler
                } else {
                    print("Error getting download URL:", error?.localizedDescription ?? "Unknown error")
                }
            }
        }
        
        // Observe the upload progress if needed
        uploadTask.observe(.progress) { snapshot in
            // Handle progress updates if needed
        }
    }
}
