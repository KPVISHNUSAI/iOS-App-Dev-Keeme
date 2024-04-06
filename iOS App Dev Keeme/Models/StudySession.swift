////
////  StudySession.swift
////  iOS App Dev Keeme
////
////  Created by user2 on 24/03/24.
////
//
//import Foundation
//import FirebaseFirestoreSwift
//
//struct Keemespace: Codable {
//    let keemeId: String
//    var sessionName: String
//    var description: String
//    var dateTime: Date
//    var creatorID: String
//    var participants: [String]
//    
//    enum CodingKeys: CodingKey {
//        case keemeId
//        case sessionName
//        case description
//        case dateTime
//        case creatorID
//        case participants
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.keemeId = try container.decode(String.self, forKey: .keemeId)
//        self.sessionName = try container.decode(String.self, forKey: .sessionName)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.dateTime = try container.decode(Date.self, forKey: .dateTime)
//        self.creatorID = try container.decode(String.self, forKey: .creatorID)
//        self.participants = try container.decode([String].self, forKey: .participants)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.keemeId, forKey: .keemeId)
//        try container.encode(self.sessionName, forKey: .sessionName)
//        try container.encode(self.description, forKey: .description)
//        try container.encode(self.dateTime, forKey: .dateTime)
//        try container.encode(self.creatorID, forKey: .creatorID)
//        try container.encode(self.participants, forKey: .participants)
//    }
//    
//    
//}
