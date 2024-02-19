import SwiftUI

struct FavouritesView: View {
    @State private var searchText = ""
    
    @State private var users: [UserModel] = [
        UserModel(displayName: "Rita", userName: "rita123", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "John", userName: "john456", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Alice", userName: "alice789", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Bob", userName: "bob321", taskDescription: "Working on a new project", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Eva", userName: "eva567", taskDescription: "Preparing for upcoming exams", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "David", userName: "david890", taskDescription: "Learning SwiftUI", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Sophie", userName: "sophie234", taskDescription: "Gardening in the backyard", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Michael", userName: "michael567", taskDescription: "Running a marathon", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Emma", userName: "emma890", taskDescription: "Cooking a new recipe", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Daniel", userName: "daniel123", taskDescription: "Writing a blog post", isFavourite: false, date: Date(), noOfMeetsAttended: 5),
        UserModel(displayName: "Olivia", userName: "olivia456", taskDescription: "Traveling to a new city", isFavourite: true, date: Date(), noOfMeetsAttended: 5),
        // Add more dummy data as needed
    ]

    
    var filteredUsers: [UserModel] {
            if searchText.isEmpty {
                return users.filter { user in
                    user.isFavourite
                }
            } else {
                return users.filter { user in
                    user.displayName.localizedCaseInsensitiveContains(searchText) || user.userName.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $searchText)
                List {
                    ForEach(filteredUsers) {user in
                        Section(header: EmptyView()) {
                            NavigationLink(destination: FavouritesProfileView(user: user)) {
                                HStack(spacing: 15) {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                    VStack(alignment: .leading) {
                                        HStack(alignment:.center){
                                            Text(user.displayName)
                                                .font(.headline)
                                            if (user.isFavourite) {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.yellow)
                                            }
                                        }
                                        
                                        Text("@\(user.userName)")
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                    }
                                    Spacer()
                                    
                                }
                            }
                            

                        }
                    }.onDelete(perform: delete)
                }.listStyle(.insetGrouped)
                    .listSectionSpacing(.compact)
            }
            .navigationTitle("Favourites")
        }
    }
    
    func delete(indexSet: IndexSet){
        users.remove(atOffsets: indexSet)
    }
}


struct FavouritesProfileView: View {
    var user: UserModel

    var body: some View {
        VStack {
            Text("Profile for \(user.displayName)")
            // Add other details you want to display on the user's profile page
        }
        .navigationTitle(user.displayName)
    }
}


struct SearchBar: View {
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


#Preview {
    FavouritesView()
}

