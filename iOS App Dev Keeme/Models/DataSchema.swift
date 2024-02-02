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
    var definedTask : String
    var keemeSpaceDate : Date
    //var startTime : //Time data type how to get it not sure
    //var endTime : //how to get time data type not sure
    //var duration : // this should also be the timer duration to be shown as the timer bar in the keemespace
    var numberOfPeople : Int
    var acheivements : [String]
    
    init(keemeSpaceName: String = "" , definedTask: String = "" , keemeSpaceDate: Date = Date(), numberOfPeople: Int = 1, acheivements: [String] = [String]()) {
        self.keemeSpaceName = keemeSpaceName
        self.definedTask = definedTask
        self.keemeSpaceDate = keemeSpaceDate
        self.numberOfPeople = numberOfPeople
        self.acheivements = acheivements
    }
    
    
}
