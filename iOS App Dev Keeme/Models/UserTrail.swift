//
//  User.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 29/02/24.
//

import Foundation
import SwiftData

@Model
class UserTrail {
    var userID = UUID()
    var firstName: String
    var lastName: String
    var isfav:Bool
    @Attribute(.unique) var username: String
    var favouritebuddies = [UserTrail]()
    
    //    var DateOfBirth: Date
    //    var about: String
    //    var country: String
    //    var socials: URL?
    //    var qualification: String
    //    var school: String
        //@Attribute(.unique)
    //    var emailID: String
    //
    //    var password: String
    
    var keemes : [KeemeSpace]?
    init(userID: UUID = UUID(), firstName: String, lastName: String, isfav: Bool, username: String, favouritebuddies: [UserTrail] = [UserTrail](), keemes: [KeemeSpace]? = nil) {
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.isfav = isfav
        self.username = username
        self.favouritebuddies = favouritebuddies
        self.keemes = keemes
    }
}





//
//let SampleUserdata: [User] = [
//    User(firstName: "Rahul", lastName: "Sharma", isfav: false, username: "rahulsharma",favouritebuddies: [],keemes:[SampleKeemeSpace[0]]),
//    User(firstName: "Priya", lastName: "Singh", isfav: true, username: "priyasingh",favouritebuddies:
//            [SampleUserdata[0],SampleUserdata[2]],keemes: [SampleKeemeSpace[1]]),
//    User(firstName: "Neha", lastName: "Patel", isfav: false, username: "nehapatel",favouritebuddies:
//            [SampleUserdata[1],SampleUserdata[2]],keemes: [SampleKeemeSpace[2]]),
//    User(firstName: "Rohit", lastName: "Kumar", isfav: true, username: "rohitkumar",favouritebuddies:
//            [SampleUserdata[0],SampleUserdata[2]],keemes: [SampleKeemeSpace[3]])
//]
//
//
