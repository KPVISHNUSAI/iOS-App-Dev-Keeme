import Foundation
import UIKit
import PhotosUI

struct UserProfile {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var age: Int {
        calculateAge()
    }
    var profileImage: UIImage?
    var biography: String
    var gender: Gender
    var phoneNumber: String
    var address: Address
    var education: Education
    var linkedinProfile: String
    

    init(
        firstName: String = "Lauren",
        lastName: String = "Gomez",
        `var` dateOfBirth: Date = {
        var components = DateComponents()
        components.year = 2003
        components.month = 11
        components.day = 11
        return Calendar.current.date(from: components) ?? Date()
    }()
,
        profileImage: UIImage = UIImage(resource: .lauren),
        biography: String = "",
        gender: Gender = .unspecified,
        phoneNumber: String = "",
        address: Address = Address(),
        education: Education = Education(),
        linkedinProfile: String = ""
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.profileImage = profileImage
        self.biography = biography
        self.gender = gender
        self.phoneNumber = phoneNumber
        self.address = address
        self.education = education
        self.linkedinProfile = linkedinProfile
    }

    // Add more properties as needed

    // Define nested structs for Address and Education
    struct Address {
        var street: String = "123 Main Street"
        var city: String = "Cityville"
        var state: String = "State"
        var zipCode: String = "12345"
        var country: String = "Country"
    }

    struct Education {
        var schoolName: String = "University of Example"
        var degree: String = "Bachelor's Degree"
        var major: String = "Computer Science"
        var graduationYear: Date = {
            var components = DateComponents()
            components.year = 2025
            return Calendar.current.date(from: components) ?? Date()
        }()
    }

    // Age calculation function
    private func calculateAge() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: currentDate)
        return ageComponents.year ?? 0
    }
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    case unspecified = "Unspecified"
}

struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    let displayName: String
    let userName: String
    let taskDescription: String
    let isFavourite: Bool
    let date: Date
    let noOfMeetsAttended: Int

    // Function to generate random dates and times
    static func randomDate() -> Date {
        let randomDaysAgo = Int.random(in: 1...10)
        let randomHoursAgo = Int.random(in: 1...24)
        return Calendar.current.date(byAdding: .hour, value: -randomHoursAgo, to: Calendar.current.date(byAdding: .day, value: -randomDaysAgo, to: Date())!)!
    }
}
