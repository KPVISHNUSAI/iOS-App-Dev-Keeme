//
//  KeemespaceManager.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 25/03/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct JoinRequest: Codable, Identifiable {
    var id = UUID()
    let keemeId: String
    let userID: String
    let timestamp: Date
    var status: String
    
    init(id: UUID = UUID(),keemeId: String, userID: String, timestamp: Date, status: String) {
            self.id = id
            self.keemeId = keemeId
            self.userID = userID
            self.timestamp = timestamp
            self.status = status
    }
}

struct Keemespace: Codable {
    let keemeId: String
    var sessionName: String
    var description: String
    var startTime: Date
    var endTime: Date
    var creatorID: String
    var participants: [String]
    var joinRequests: [JoinRequest]
    
    enum CodingKeys: String, CodingKey {
        case keemeId
        case sessionName
        case description
        case startTime
        case creatorID
        case participants
        case joinRequests
        case endTime
    }
    
    init(keemeId: String,
         sessionName: String,
         description: String,
         startTime: Date,
         endTime: Date,
         creatorID: String,
         participants: [String] = [],
         joinRequests: [JoinRequest] = []) {
        self.keemeId = keemeId
        self.sessionName = sessionName
        self.description = description
        self.startTime = startTime
        self.endTime = endTime
        self.creatorID = creatorID
        self.participants = participants
        self.joinRequests = joinRequests
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.keemeId = try container.decode(String.self, forKey: .keemeId)
        self.sessionName = try container.decode(String.self, forKey: .sessionName)
        self.description = try container.decode(String.self, forKey: .description)
        self.startTime = try container.decode(Date.self, forKey: .startTime)
        self.endTime = try container.decode(Date.self, forKey: .endTime)
        self.creatorID = try container.decode(String.self, forKey: .creatorID)
        self.participants = try container.decode([String].self, forKey: .participants)
        self.joinRequests = try container.decode([JoinRequest].self, forKey: .joinRequests)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.keemeId, forKey: .keemeId)
        try container.encode(self.sessionName, forKey: .sessionName)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.startTime, forKey: .startTime)
        try container.encode(self.endTime, forKey: .endTime)
        try container.encode(self.creatorID, forKey: .creatorID)
        try container.encode(self.participants, forKey: .participants)
        try container.encode(self.joinRequests, forKey: .joinRequests)
    }
}

final class KeemespaceManager {
    static let shared = KeemespaceManager()
    private init(){ }
    
    private let keemeCollection = Firestore.firestore().collection("keemespace")
    
    private func keemeDocument(keemeId: String) -> DocumentReference {
        keemeCollection.document(keemeId)
    }
    
    func createKeemespace(keemespace: Keemespace) async throws {
        try keemeDocument(keemeId: keemespace.keemeId).setData(from: keemespace, merge: false)
    }
    
    func getKeemespace(keemeId: String) async throws -> Keemespace {
        try await keemeDocument(keemeId: keemeId).getDocument(as: Keemespace.self)
    }
    
    func getKeemespaces(byCreatorId creatorId: String) async throws -> [Keemespace] {
        let currentDate = Date()
        let query = keemeCollection.whereField("creatorID", isEqualTo: creatorId)
        let querySnapshot = try await query.getDocuments()
        return try querySnapshot.documents.compactMap { document in
            try document.data(as: Keemespace.self)
        }
    }
    
    func getAllKeemespaces(except userId: String) async throws -> [Keemespace] {
        let currentDate = Date()
        let query = keemeCollection.whereField("creatorID", isNotEqualTo: userId).whereField("startTime", isGreaterThanOrEqualTo: currentDate)
        let querySnapshot = try await query.getDocuments()
        return try querySnapshot.documents.compactMap { document in
            try document.data(as: Keemespace.self)
        }
    }
    
        
    func joinKeemespace(keemeId: String, userID: String) async throws {
        let keemeRef = keemeDocument(keemeId: keemeId)
        try await keemeRef.updateData([
            "participants": FieldValue.arrayUnion([userID])
        ])
    }
    
        
//    func requestToJoinKeemespace(keemeId: String, userId: String) async throws {
//        let keemeRef = keemeDocument(keemeId: keemeId)
//        let joinRequest = JoinRequest( keemeId: keemeId, userID: userId, timestamp: Date(), status: "pending")
//
//        // Add the join request to the keemespace document
//        try await keemeRef.updateData([
//            "joinRequests": FieldValue.arrayUnion([try Firestore.Encoder().encode(joinRequest)])
//        ])
//    }
    
    func requestToJoinKeemespace(keemeId: String, userId: String) async throws {
        let keemeRef = keemeDocument(keemeId: keemeId)
        
        // Fetch the current Keemespace
        var keemespace = try await keemeRef.getDocument(as: Keemespace.self)
        
        // Check if the user has already requested to join this Keemespace
        if keemespace.joinRequests.contains(where: { $0.userID == userId }) {
            print("User has already requested to join this Keemespace.")
            return
        }
        
        // If the user has not already requested to join, create and add the join request
        let joinRequest = JoinRequest(keemeId: keemeId, userID: userId, timestamp: Date(), status: "pending")
        
        // Update the Keemespace document with the new join request
        try await keemeRef.updateData([
            "joinRequests": FieldValue.arrayUnion([try Firestore.Encoder().encode(joinRequest)])
        ])
    }

    
//    func respondToJoinRequest(keemeId: String, userID: String, status: String) async throws {
//        let keemeRef = keemeDocument(keemeId: keemeId)
//        if status == "accepted" {
//            try await keemeRef.updateData([
//                "participants": FieldValue.arrayUnion([userID])
//            ])
//        }
//        try await keemeRef.updateData([
//            "joinRequests": FieldValue.arrayRemove([
//                ["keemeId": keemeId, "userID": userID, "timestamp": Date(), "status": "pending"]
//            ])
//        ])
//    }
    
    
//    func respondToJoinRequest(id: UUID, keemeId: String, userID: String, status: String) async throws {
//        let keemeRef = keemeDocument(keemeId: keemeId)
//        if status == "accepted" {
//            // If status is "accepted", add the user to the participants array
//            try await keemeRef.updateData([
//                "participants": FieldValue.arrayUnion([userID])
//            ])
//        } else if status == "rejected" {
//            // If status is "rejected", remove the join request
//            try await keemeRef.updateData([
//                "joinRequests": FieldValue.arrayRemove([
//                    ["id": id, "userID": userID, "timestamp": Date(), "status": "pending"]
//                ])
//            ])
//            return // Exit early as there's nothing more to do if the request is rejected
//        }
//        
//        // Update the status of the join request to reflect the decision
//        try await keemeRef.updateData([
//            "joinRequests": FieldValue.arrayUnion([
//                ["userID": userID, "timestamp": Date(), "status": status]
//            ])
//        ])
//    }
    func respondToJoinRequest(id: UUID, keemeId: String, userID: String, status: String) async throws {
        let keemeRef = keemeDocument(keemeId: keemeId)
        
        // Get the current Keemespace
        var keemespace = try await keemeRef.getDocument(as: Keemespace.self)
        
        // Find the index of the join request in the Keemespace's joinRequests array
        if let index = keemespace.joinRequests.firstIndex(where: { $0.id == id }) {
            // Update the status of the join request
            keemespace.joinRequests[index].status = status
        } else {
            // If join request not found, print error and return
            print("Error: Join request with id \(id) not found in the Keemespace.")
            return
        }
        
        // Update the Keemespace document
        try await keemeRef.setData(from: keemespace)
    }

    

    
    
    func getJoinRequestsForCreator(userId: String) async throws -> [JoinRequest] {
            let querySnapshot = try await keemeCollection.whereField("creatorID", isEqualTo: userId).getDocuments()
            var joinRequests: [JoinRequest] = []

            for document in querySnapshot.documents {
                guard let keemespace = try? document.data(as: Keemespace.self) else {
                    continue
                }
                // Filter join requests for this Keemespace
                let requests = keemespace.joinRequests.filter { $0.status == "pending" }
                joinRequests.append(contentsOf: requests)
            }

            return joinRequests
        }

}


extension DBUser {
    func detailsNotFilledOut() -> Bool {
        return firstName == nil || lastName == nil // Add more conditions if needed
    }
}
