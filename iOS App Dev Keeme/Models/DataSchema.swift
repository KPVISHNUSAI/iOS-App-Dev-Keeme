//
//  DataSchema.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 02/02/24.
//

import Foundation
import SwiftData

@Model
class User {
    let id = UUID()
    var firstName : String
    var lastName : String
    var dateOfBirth : Date
    // var password : string
    var about : String
    var country : String //it should be converted to enum
    var socials : URL?
    var qualification : String? //it should also be enum
    var school : String?
    //var keemedesc : String?
    // var favourites = array of users
    // var bookings = array of keemespace data type
    init(firstName: String = "" , lastName: String = "" , dateOfBirth: Date = Date(), about: String = "", country: String = "", socials: URL? = nil, qualification: String? = nil, school: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.about = about
        self.country = country
        self.socials = socials
        self.qualification = qualification
        self.school = school
    }
}



@Model
class KeemeSpace {
    let keemeSpaceId = UUID()
    var keemeSpaceName : String
    var keemeDesc : String
    var keemeSpaceDate : Date
    //var startTime : //Time data type how to get it not sure
    //var endTime : //how to get time data type not sure
    //var duration : // this should also be the timer duration to be shown as the timer bar in the keemespace
    var numberOfPeople : Int
    var acheivements : [String]
    
    init(keemeSpaceName: String = "" , keemeDesc: String = "" , keemeSpaceDate: Date = Date(), numberOfPeople: Int = 1, acheivements: [String] = [String]()) {
        self.keemeSpaceName = keemeSpaceName
        self.keemeDesc = keemeDesc
        self.keemeSpaceDate = keemeSpaceDate
        self.numberOfPeople = numberOfPeople
        self.acheivements = acheivements
    }
    
    
}


//
//struct Listing: Identifiable {
//    let id: Int
//    let imageName: String
//    let name: String
//    let description: String
//    let time: String
//    
//    static let sampleListings: [Listing] = [
//        Listing(id: 1, imageName: "rita", name: "Rita", description: "Today I am starting to organize my notes in notion", time: "6:00am - 7:00am"),
//        Listing(id: 2, imageName: "shelly", name: "Shelly", description: "I am going to learn a new skill or language by learning in coursera", time: "9:30am - 10:30am"),
//        Listing(id: 3, imageName: "kyle", name: "Kyle", description: "Going to review my monthly expenses", time: "12:00pm - 1:00pm"),
//        Listing(id: 4, imageName: "henry", name: "Henry", description: "Complete the assingments of CODING", time: "4:30pm - 5:30pm"),
//        Listing(id: 5, imageName: "1", name: "James", description: "Will practice problems in LeetCode", time: "7:00pm - 8:00pm"),
//        Listing(id: 6, imageName: "8", name: "Saloni Patel", description: "Need to prepare presenataions", time: "9:30pm - 10:30pm"),
//        Listing(id: 7, imageName: "5", name: "Harry", description: "Hustle on DSA problems in CodeChef", time: "11:00pm - 12:00am"),
//    ]
//}
//
