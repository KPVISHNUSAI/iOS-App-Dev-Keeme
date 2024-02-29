//
//  DataModels.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 07/02/24.
//

import Foundation
import SwiftData
import SwiftUI


// MARK: - Student Model

@Model final class Student {
    @Attribute(.unique) var studentID: Int
    var emailID: String
    var password: String // Consider using a secure storage mechanism for passwords
    var firstName: String
    var lastName: String

    // Foreign key relationships (using macros for clarity and efficiency)
    @Relationship(deleteRule: .cascade)
    var meetings: [Meeting]?

//    @Relationship(deleteRule: .nullify, inverse: \FavoriteStudents.favoriteStudent)
    @Relationship(deleteRule: .nullify)
    var favoritedBy: [FavoriteStudents]?

//    @Relationship(deleteRule: .cascade, inverse: \Meeting.meetingID)
    @Relationship(deleteRule: .cascade)
    var favoritedMeetings: [Meeting] = []

    init(studentID: Int, emailID: String, password: String, firstName: String, lastName: String, meetings: [Meeting], favoritedBy: [FavoriteStudents], favoritedMeetings: [Meeting]) {
        self.studentID = studentID
        self.emailID = emailID
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.meetings = meetings
        self.favoritedBy = favoritedBy
        self.favoritedMeetings = favoritedMeetings
    }
    
    // Convenience methods for fetching related objects
//    func fetchMeetings() async throws -> [Meeting] {
//        try await ModelContext.shared.fetch(meetingID: studentID, relationship: meetings)
//    }
//
//    func fetchFavoritedBy() async throws -> [Student] {
//        try await ModelContext.shared.fetch(relatedTo: studentID, relationship: favoritedBy)
//    }
//
//    func fetchFavoritedMeetings() async throws -> [Meeting] {
//        try await ModelContext.shared.fetch(meetingID: studentID, relationship: favoritedMeetings)
//    }
}

// MARK: - Meeting Model

@Model
final class Meeting {
    //@Attribute(.unique)
    var meetingID: Int
    
    var task: String
    var startTime: Date
    var endTime: Date
    var creatorID: Int
    var preference: String

    init(meetingID: Int, task: String, startTime: Date, endTime: Date, creatorID: Int, preference: String, creator: Student) {
        self.meetingID = meetingID
        self.task = task
        self.startTime = startTime
        self.endTime = endTime
        self.creatorID = creatorID
        self.preference = preference
        self.creator = creator
    }
    // Foreign key relationship (using macro for clarity)
    @Relationship(deleteRule: .nullify)
    var creator: Student

    // Convenience method for fetching the creator
//    func fetchCreator() async throws -> Student {
//        try await ModelContext.shared.fetch(studentID: creatorID, relationship: "creator")
//    }
}

// MARK: - StudentMeeting Model

@Model
final class StudentMeeting {
    @Attribute(.unique)
    var studentID: Int
    
    @Attribute(.unique)
    var meetingID: Int



    @Relationship(deleteRule: .nullify)
    var student: Student

    @Relationship(deleteRule: .nullify)
    var meeting: Meeting

    init(studentID: Int, meetingID: Int, student: Student, meeting: Meeting) {
        self.studentID = studentID
        self.meetingID = meetingID
        self.student = student
        self.meeting = meeting
    }
    
    // Convenience methods for fetching related objects
//    func fetchStudent() async throws -> Student {
//        try await ModelContext.shared.fetch(studentID: studentID, relationship: "student")
//    }
//    
//    func fetchMeeting() async throws -> Meeting {
//        try await ModelContext.shared.fetch(meetingID: meetingID, relationship: "meeting")
//    }
}

// MARK: - FavoriteStudents Model

@Model
final class FavoriteStudents {
    
    @Attribute(.unique)
    var studentID: Int
    
    @Attribute(.unique)
    var favoriteStudentID: Int
    
    
    // Foreign key relationships (using macros for clarity and efficiency)

    @Relationship(deleteRule: .nullify)
    var student: Student

    @Relationship(deleteRule: .nullify)
    var favoriteStudent: Student

    init(studentID: Int, favoriteStudentID: Int, student: Student, favoriteStudent: Student) {
        self.studentID = studentID
        self.favoriteStudentID = favoriteStudentID
        self.student = student
        self.favoriteStudent = favoriteStudent
    }
    
    // Convenience methods for fetching related objects
//    func fetchStudent() async throws -> Student {
//        try await ModelContext.shared.fetch(studentID: studentID, relationship: "student")
//    }
//
//    func fetchFavoriteStudent() async throws -> Student {
//        try await ModelContext.shared.fetch(studentID: favoriteStudentID, relationship: "favoriteStudent")
//    }
}

// MARK: - FavoriteMeetings Model


@Model
final class FavoriteMeetings {
    @Attribute(.unique) var studentID: Int

    @Attribute(.unique) var meetingID: Int

    // Foreign key relationships (using macros for clarity and efficiency)

    @Relationship(deleteRule: .nullify)
    var student: Student

    @Relationship(deleteRule: .nullify)
    var meeting: Meeting

    init(studentID: Int, meetingID: Int, student: Student, meeting: Meeting) {
        self.studentID = studentID
        self.meetingID = meetingID
        self.student = student
        self.meeting = meeting
    }
    // Convenience methods for fetching related objects
//    func fetchStudent() async throws -> Student {
//        try await ModelContext.shared.fetch(studentID: studentID, relationship: "student")
//    }
//
//    func fetchMeeting() async throws -> Meeting {
//        try await ModelContext.shared.fetch(meetingID: meetingID, relationship: "meeting")
//    }
//
//    // Additional methods based on feedback and potential use cases:
//
//    // Check if a specific meeting is favorited by a given student
//    func isFavorited(by student: Student) async throws -> Bool {
//        let existingFavorite = try await ModelContext.shared.fetch(
//            FavoriteMeetings.self,
//            filters: [
//                (.field("studentID"), .equal(student.studentID)),
//                (.field("meetingID"), .equal(meetingID)),
//            ]
//        ).first
//        return existingFavorite != nil
//    }
//
//    // Remove a meeting from a student's favorites
//    func removeFromFavorites(of student: Student) async throws {
//        guard try await isFavorited(by: student) else { return }
//        try await ModelContext.shared.delete(
//            FavoriteMeetings.self,
//            filters: [
//                (.field("studentID"), .equal(student.studentID)),
//                (.field("meetingID"), .equal(meetingID)),
//            ]
//        )
//    }
//
//    // Add a meeting to a student's favorites (assuming uniqueness check and error handling)
//    func addToFavorites(of student: Student) async throws {
//        if try await isFavorited(by: student) { return }
//        let newFavorite = FavoriteMeetings(studentID: student.studentID, meetingID: meetingID)
//        try await ModelContext.shared.save(newFavorite)
//    }
//
//    // Fetch all meetings favorited by a given student
//    func fetchAllFavorites(for student: Student) async throws -> [Meeting] {
//        let favoriteMeetingIDs = try await ModelContext.shared.fetch(
//            StudentMeeting.self,
//            filters: [.field("studentID"), .equal(student.studentID)],
//            select: [.field("meetingID")]
//        ).map { $0.meetingID }
//        return try await ModelContext.shared.fetch(
//            Meeting.self,
//            filters: [.field("meetingID"), .in(favoriteMeetingIDs)]
//        )
//    }
}
