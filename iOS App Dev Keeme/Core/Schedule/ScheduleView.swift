import SwiftUI
//import SwiftUIIntrospect
import SwiftData




struct ScheduleView: View {
    @State private var isAddScheduleViewPresented = false
    @Environment(\.modelContext) private var context
    @Query(sort: \KeemeSpace.startTime) private var KeemeSpaceVar: [KeemeSpace]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(KeemeSpaceVar) { KSV in
                        Section(header: EmptyView()) {
                            NavigationLink(destination: ShowScheduleView(KSV: KSV)){
                                HStack(spacing: 15) {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                    VStack(alignment: .leading) {
                                        HStack(alignment: .center) {
                                            Text(KSV.keemeSpaceName)
                                                .font(.headline)
    //                                        if meeting.preference == "Favourites" {
    //                                            Image(systemName: "star.fill")
    //                                                .foregroundColor(.yellow)
    //                                        }
                                        }
                                        Text(KSV.keemeDescription)
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        Text("\(KSV.startTime, style: .date) \(KSV.startTime, style: .time)")
                                            .font(.caption)
                                            .foregroundColor(.purpleSet)
                                            .bold()
                                    }
                                    Spacer()
                                }
                            }
                            
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let KeemeSV = KeemeSpaceVar[index]
                            context.delete(KeemeSV)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .listSectionSpacing(.compact)
                .navigationTitle("Schedule")
            }
            .overlay(
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ArrangeSchedule()) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Circle().fill(Color.purpleSet))
                            .foregroundColor(.white)
                    }
                }
                    .padding() , alignment: .bottomTrailing
            )
        }
    }
    
}


struct ShowScheduleView: View {
    var KSV: KeemeSpace
    var body: some View {
        VStack {
            Image(systemName: "person.3.fill")
                .font(.system(size: 150))
                .padding(10)
            HStack{
                VStack(alignment: .leading){
                    Text("Name: \(KSV.keemeSpaceName)")
                    Text("Number of Favourites: \(KSV.keemeDescription)")
                    Text("\(KSV.startTime, style: .date) \(KSV.startTime, style: .time)")
                    
                }
                Spacer()
            }.padding()
            
            // Add other details you want to display on the user's profile page
            
            Spacer()
        }
        .navigationTitle(KSV.keemeSpaceName)
    }
    
    
    
}




//struct ScheduleView: View {
//    @State private var isAddScheduleViewPresented = false
//    @Environment(\.modelContext) private var context
//    @Query(sort: \Meeting.startTime) private var meetings: [Meeting]
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(meetings) { meeting in
//                        Section(header: EmptyView()) {
//                            HStack(spacing: 15) {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                VStack(alignment: .leading) {
//                                    HStack(alignment: .center) {
//                                        Text(meeting.task)
//                                            .font(.headline)
//                                        if meeting.preference == "Favourites" {
//                                            Image(systemName: "star.fill")
//                                                .foregroundColor(.yellow)
//                                        }
//                                    }
//                                    Text(meeting.task)
//                                        .foregroundColor(.gray)
//                                        .font(.caption)
//                                        .lineLimit(1)
//                                        .truncationMode(.tail)
//                                    Text("\(meeting.startTime, style: .date) \(meeting.startTime, style: .time)")
//                                        .font(.caption)
//                                        .foregroundColor(.purpleSet)
//                                        .bold()
//                                }
//                                Spacer()
//                                Image(systemName: "arrowshape.right.circle.fill")
//                                    .foregroundColor(.red)
//                            }
//                        }
//                    }
//                    .onDelete { indexSet in
//                        indexSet.forEach { index in
//                            let meeting = meetings[index]
//                            context.delete(meeting)
//                        }
//                    }
//                }
//                .listStyle(.insetGrouped)
//                .listSectionSpacing(.compact)
//                .navigationTitle("Schedule")
//            }
//            .overlay(
//
//                HStack {
//                    Spacer()
//                    NavigationLink(destination: ArrangeSchedule()) {
//                        Image(systemName: "plus")
//                            .padding()
//                            .background(Circle().fill(Color.purpleSet))
//                            .foregroundColor(.white)
//                    }
//                }
//                    .padding() , alignment: .bottomTrailing
//            )
//        }
//    }
//}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .modelContainer(for: Meeting.self, inMemory: true)
    }
}




//    @State var users: [UserModel] = [
//        UserModel(displayName: "Rita", userName: "rita123", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "John", userName: "john456", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Alice", userName: "alice789", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Bob", userName: "bob321", taskDescription: "Working on a new project", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Eva", userName: "eva567", taskDescription: "Preparing for upcoming exams", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "David", userName: "david890", taskDescription: "Learning SwiftUI", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Sophie", userName: "sophie234", taskDescription: "Gardening in the backyard", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Michael", userName: "michael567", taskDescription: "Running a marathon", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Emma", userName: "emma890", taskDescription: "Cooking a new recipe", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Daniel", userName: "daniel123", taskDescription: "Writing a blog post", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
//        UserModel(displayName: "Olivia", userName: "olivia456", taskDescription: "Traveling to a new city", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
//        // Add more dummy data as needed
    //]
