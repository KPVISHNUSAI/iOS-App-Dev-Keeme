import SwiftUI
import SwiftData


struct Listings: View {
    @Environment(\.modelContext) private var context
    //@Bindable var UserCard : [User]
    @Query private var UserCard: [User]
    @Query(sort: \KeemeSpace.startTime) private var keeme : [KeemeSpace]
    @State private var searchText = ""
    
//    let listing: Listing
    //var list:User
//    init(){
//        addUserplz()
//    }
    
    var filteredUsers: [User] {
            if searchText.isEmpty {
                return UserCard
            } else {
                return UserCard.filter { user in
                    user.username.lowercased().contains(searchText.lowercased())
                }
            }
        }
    
    var body: some View {
        NavigationView {
            VStack {
//              Button("add plz add data", action: addUserplz)
                SearchBarFind(text: $searchText)
                List {
                    ForEach(filteredUsers) { user in
                        ForEach(keeme){
                            keemespace in
                            
                            Section(header: EmptyView()) {
                                NavigationLink(destination: NewView(user: user)){
                                    HStack(spacing: 15) {
                                        Circle()
                                            .frame(width: 40, height: 40)
                                        VStack(alignment: .leading) {
                                            HStack(alignment: .center) {
                                                Text(user.username)
                                                    .font(.headline)
                                                //                                        if meeting.preference == "Favourites" {
                                                //                                            Image(systemName: "star.fill")
                                                //                                                .foregroundColor(.yellow)
                                            }
                                            
                                            
                                            Text(keemespace.keemeSpaceName)
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                            
                                            
                                            Text("\(keemespace.startTime, style: .date) \(keemespace.startTime, style: .time)")
                                                .font(.caption)
                                                .foregroundColor(.purpleSet)
                                                .bold()
                                            
                                            
                                        }
                                        Spacer()
                                        
                                    }
                                    
                                }
                                
                                //Spacer()
                                
                            }
                        }
                    }
                }.listStyle(.insetGrouped)
                    .listSectionSpacing(.compact)

//                    .onDelete { indexSet in
//                        indexSet.forEach { index in
//                            let user = UserCard[index]
//                            context.delete(user)
                        }
                    }
                }
//                .listStyle(.insetGrouped)
//                .listSectionSpacing(.compact)
//                .navigationTitle("Schedule")
    
    
//    struct CardView: View {
//      let username: String
//      let keemeSpaceName: String
//      let keemeDescription: String
//
//      var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//          HStack(alignment: .center) {
//            Circle()
//              .frame(width: 40, height: 40)
//            Text(username)
//              .font(.headline)
//          }
//          Text(keemeSpaceName)
//            .foregroundColor(.gray)
//            .font(.caption)
//            .lineLimit(1)
//            .truncationMode(.tail)
//          Text(keemeDescription)
//            .font(.caption)
//            .foregroundColor(.purpleSet)
//            .bold()
//            .lineLimit(2) // Limit description lines to 2
//            .truncationMode(.tail) // Add ellipsis "..." if description is too long
//          Spacer()
//          Image(systemName: "arrowshape.right.circle.fill")
//            .foregroundColor(.red)
//        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2)) // Rounded corners and shadow for card style
//      }
//    }
    
    
    
    func addUserplz(){
        let SampleKeemeSpace1 = KeemeSpace(keemeSpaceName: "Calculus Study Group", keemeDescription: "Join us for a collaborative session to tackle challenging calculus problems!", startTime: Date(), endTime: Date(timeInterval: 60 * 60, since: Date()), duration: Date(timeInterval: 60 * 60, since: Date()), maxStudents: 5)
        
        let SampleKeemeSpace2 =     KeemeSpace(keemeSpaceName: "Literature Discussion", keemeDescription: "Discuss your thoughts and interpretations of the latest assigned reading!", startTime: Date(timeInterval: 3600, since: Date()), endTime: Date(timeInterval: 3600 * 2, since: Date()), duration: Date(timeInterval: 3600, since: Date()), maxStudents: 8)
        let SampleKeemeSpace3 = KeemeSpace(keemeSpaceName: "Python Coding Help Session", keemeDescription: "Need help with your Python coding assignments? Get assistance from experienced peers!", startTime: Date(timeInterval: 7200, since: Date()), endTime: Date(timeInterval: 10800, since: Date()), duration: Date(timeInterval: 3600, since: Date()), maxStudents: 3)
        let SampleKeemeSpace4 = KeemeSpace(keemeSpaceName: "History Exam Review", keemeDescription: "Review key concepts and test your knowledge before the upcoming history exam!", startTime: Date(timeInterval: 14400, since: Date()), endTime: Date(timeInterval: 18000, since: Date()), duration: Date(timeInterval: 3600, since: Date()), maxStudents: 10)
    
        
        let SampleUserdata1 = User(firstName: "Rahul", lastName: "Sharma", isfav: false, username: "rahulsharma",keemes: [SampleKeemeSpace1])
        let SampleUserdata2 =    User(firstName: "Priya", lastName: "Singh", isfav: true, username: "priyasingh",keemes: [SampleKeemeSpace2])
        let SampleUserdata3 =  User(firstName: "Neha", lastName: "Patel", isfav: false, username: "nehapatel",keemes: [SampleKeemeSpace3])
        let SampleUserdata4 = User(firstName: "Rohit", lastName: "Kumar", isfav: true, username: "rohitkumar",keemes: [SampleKeemeSpace4])
        context.insert(SampleUserdata1)
        context.insert(SampleUserdata2)
        context.insert(SampleUserdata3)
        context.insert(SampleUserdata4)
        
    }
    
            }
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
//                .padding() , alignment: .bottomTrailing
//            )
//        }
//    }



//
//#Preview {
//    let previewVar = Preview()
//    previewVar.addExamples(User.SampleUserdata)
//    return Listings()
//        .modelContainer(previewVar.container)
//}


///struct Listings_Previews: PreviewProvider {
////    static var previews: some View {
////        //Listings(listing: Listing.sampleListings[0])
////    }
//}
//


struct SearchBarFind: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 15)
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
            }
            .padding(.trailing, 10)
            .opacity(text.isEmpty ? 0 : 1)
            .animation(.easeInOut)
        }
        .padding(.bottom, 8)
    }
}


struct NewView: View {
    var user: User
    var body: some View {
        VStack{
            Text("Hello, \(user.username)")
            
        }
    }
}
