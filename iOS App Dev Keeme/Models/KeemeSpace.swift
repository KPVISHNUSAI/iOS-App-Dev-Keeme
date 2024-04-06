////
////  KeemeSpace.swift
////  iOS App Dev Keeme
////
////  Created by user2 on 29/02/24.
////
//
//import Foundation
//import SwiftData
//
////@Model
//class KeemeSpace {
//    var keemeSpaceID = UUID()
//    var keemeSpaceName: String
//    var keemeDescription: String
//    var startTime: Date
//    var endTime: Date
//    var duration: Date?
//    var maxStudents: Int
//    //var preference: MeetingPrefernce
//    @Relationship(deleteRule:.nullify, inverse : \Usr.username)
//    var creator: [Usr]? = [Usr]()
//    
//    init(keemeSpaceID: UUID = UUID(), keemeSpaceName: String, keemeDescription: String, startTime: Date, endTime: Date, duration: Date? = nil, maxStudents: Int) {
//        self.keemeSpaceID = keemeSpaceID
//        self.keemeSpaceName = keemeSpaceName
//        self.keemeDescription = keemeDescription
//        self.startTime = startTime
//        self.endTime = endTime
//        self.duration = duration
//        self.maxStudents = maxStudents
//    }
//
//    
//}
//
//enum MeetingPrefernce: String {
//    case favourites = "Favourites"
//    case anyone = "Anyone"
//}
//
//
////let SampleKeemeSpace: [KeemeSpace] = [
////    KeemeSpace(keemeSpaceName: "Calculus Study Group", keemeDescription: "Join us for a collaborative session to tackle challenging calculus problems!", startTime: Date(), endTime: Date(timeInterval: 60 * 60, since: Date()), duration: Date(timeInterval: 60 * 60, since: Date()), maxStudents: 5, creator: []),
////    KeemeSpace(keemeSpaceName: "Literature Discussion", keemeDescription: "Discuss your thoughts and interpretations of the latest assigned reading!", startTime: Date(timeInterval: 3600, since: Date()), endTime: Date(timeInterval: 3600 * 2, since: Date()), duration: Date(timeInterval: 3600, since: Date()), maxStudents: 8, creator: []),
////    KeemeSpace(keemeSpaceName: "Python Coding Help Session", keemeDescription: "Need help with your Python coding assignments? Get assistance from experienced peers!", startTime: Date(timeInterval: 7200, since: Date()), endTime: Date(timeInterval: 10800, since: Date()), duration: Date(timeInterval: 3600, since: Date()), maxStudents: 3, creator: []),
////    KeemeSpace(keemeSpaceName: "History Exam Review", keemeDescription: "Review key concepts and test your knowledge before the upcoming history exam!", startTime: Date(timeInterval: 14400, since: Date()), endTime: Date(timeInterval: 18000, since: Date()), duration: Date(timeInterval: 3600, since: Date()), maxStudents: 10, creator: []),
////    KeemeSpace(keemeSpaceName: "Public Speaking Workshop", keemeDescription: "Learn and practice public speaking skills in a supportive environment!", startTime: Date(timeInterval: 21600, since: Date()), endTime: Date(timeInterval: 25200, since: Date()), duration: Date(timeInterval: 3600, since: Date()), maxStudents: 7, creator: [])
////]
