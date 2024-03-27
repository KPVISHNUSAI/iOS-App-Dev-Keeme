//
//  UserSamples.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 01/03/24.
//

import Foundation

extension UserTrail{
    
    static var SampleUserdata: [UserTrail] {[
        UserTrail(firstName: "Rahul", lastName: "Sharma", isfav: false, username: "rahulsharma",keemes: []),
        UserTrail(firstName: "Priya", lastName: "Singh", isfav: true, username: "priyasingh",keemes: []),
        UserTrail(firstName: "Neha", lastName: "Patel", isfav: false, username: "nehapatel",keemes: []),
        UserTrail(firstName: "Rohit", lastName: "Kumar", isfav: true, username: "rohitkumar",keemes: [])
    ]}
    
    
}
func populateUserFavorites() {
    UserTrail.SampleUserdata[0].favouritebuddies = [UserTrail.SampleUserdata[1], UserTrail.SampleUserdata[3]]
    UserTrail.SampleUserdata[1].favouritebuddies = [UserTrail.SampleUserdata[0], UserTrail.SampleUserdata[2]]
    UserTrail.SampleUserdata[2].favouritebuddies = [UserTrail.SampleUserdata[1], UserTrail.SampleUserdata[2]]
    UserTrail.SampleUserdata[3].favouritebuddies = [UserTrail.SampleUserdata[0], UserTrail.SampleUserdata[2]]
}


