//import Foundation
//import SwiftData
//
//extension Student {
//    static var sampleStudents: [Student] {
//        [
//            Student(studentID: 1, emailID: "john@example.com", password: "password1", firstName: "John", lastName: "Doe", meetings: [], favoritedBy: [], favoritedMeetings: []),
//            Student(studentID: 2, emailID: "jane@example.com", password: "password2", firstName: "Jane", lastName: "Doe", meetings: [], favoritedBy: [], favoritedMeetings: []),
//            // Add more sample students as needed
//        ]
//    }
//}
//
//extension Meeting {
//    static var sampleMeetings: [Meeting] {
//        [
//            Meeting(meetingID: 1, task: "Discuss Project", startTime: Date(), endTime: Date(), creatorID: 1, preference: "In-person", creator: Student.sampleStudents[0]),
//            Meeting(meetingID: 2, task: "Review Code", startTime: Date(), endTime: Date(), creatorID: 2, preference: "Virtual", creator: Student.sampleStudents[1]),
//            // Add more sample meetings as needed
//        ]
//    }
//}
//
//extension StudentMeeting {
//    static var sampleStudentMeetings: [StudentMeeting] {
//        [
//            StudentMeeting(studentID: 1, meetingID: 1, student: Student.sampleStudents[0], meeting: Meeting.sampleMeetings[0]),
//            StudentMeeting(studentID: 2, meetingID: 2, student: Student.sampleStudents[1], meeting: Meeting.sampleMeetings[1]),
//            // Add more sample student meetings as needed
//        ]
//    }
//}
//
//extension FavoriteStudents {
//    static var sampleFavoriteStudents: [FavoriteStudents] {
//        [
//            FavoriteStudents(studentID: 1, favoriteStudentID: 2, student: Student.sampleStudents[0], favoriteStudent: Student.sampleStudents[1]),
//            // Add more sample favorite students as needed
//        ]
//    }
//}
//
//extension FavoriteMeetings {
//    static var sampleFavoriteMeetings: [FavoriteMeetings] {
//        [
//            FavoriteMeetings(studentID: 1, meetingID: 2, student: Student.sampleStudents[0], meeting: Meeting.sampleMeetings[1]),
//            // Add more sample favorite meetings as needed
//        ]
//    }
//}
//
