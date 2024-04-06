import SwiftUI


@MainActor
final class ScheduleViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var createdKeemeSpaces: [Keemespace] = []
    @Published private(set) var allKeemeSpaces: [Keemespace] = []
    @Published private(set) var joinRequestsForCreator: [JoinRequest] = []

    @Published private(set) var creatorDetails: [String: DBUser] = [:]
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func fetchCreatedKeemeSpaces() async throws {
        guard let user = self.user else {
            // If user is nil, return without fetching Keemespaces
            return
        }
        
        // Fetch Keemespaces created by the authenticated user
        let keemespaces = try await KeemespaceManager.shared.getKeemespaces(byCreatorId: user.userId)
        self.createdKeemeSpaces = keemespaces
    }
    
    
    
    func fetchAllKeemeSpaces() async throws {
        guard let user = self.user else {
            // If user is nil, return without fetching Keemespaces
            return
        }
        
        // Fetch all Keemespaces except those created by the authenticated user
        let allKeemespaces = try await KeemespaceManager.shared.getAllKeemespaces(except: user.userId)
        self.allKeemeSpaces = allKeemespaces
    }
    
    func fetchCreatorDetails() async throws {
        // Fetch creator details for all created keemespaces
        for keemespace in createdKeemeSpaces {
            do {
                let creator = try await UserManager.shared.getUser(userId: keemespace.creatorID)
                creatorDetails[keemespace.keemeId] = creator
            } catch {
                // Handle error
                print("Error fetching creator details for keemespace \(keemespace.keemeId): \(error)")
            }
        }
    }
    
    func requestToJoin(keemeId: String) async throws {
        guard let userId = user?.userId else {
            // Handle the case where the user is not available
            return
        }
        
        // Call the requestToJoinKeemespace method from the KeemespaceManager
        try await KeemespaceManager.shared.requestToJoinKeemespace(keemeId: keemeId, userId: userId)
        
        // You might want to refresh data after joining the keemespace
        try await fetchCreatedKeemeSpaces()
        try await fetchAllKeemeSpaces()
        try await fetchCreatorDetails()
    }
    
    func respondToJoinRequest(id: UUID, keemeId: String, userID: String, status: String) async throws {
            // Call the respondToJoinRequest method from the KeemespaceManager
        try await KeemespaceManager.shared.respondToJoinRequest(id: id, keemeId: keemeId, userID: userID, status: status)

            // You might want to refresh data after responding to the join request
            try await fetchCreatedKeemeSpaces()
            try await fetchAllKeemeSpaces()
            try await fetchCreatorDetails()
        }
    
    func fetchJoinRequestsForCreator() async throws {
            guard let userId = user?.userId else {
                // Handle the case where the user is not available
                return
            }

            // Fetch join requests for Keemespaces created by the current user
            let requests = try await KeemespaceManager.shared.getJoinRequestsForCreator(userId: userId)
            self.joinRequestsForCreator = requests
        }

    func addToFavourites(userId: String, favoriteUserId: String) async throws {
        try await UserManager.shared.addToFavouriteUsers(userId: userId, favoriteUserId: favoriteUserId)
        try await loadCurrentUser()
    }
    

        
    func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return formatter.string(from: date)
    }
}



struct ScheduleView: View {
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = ScheduleViewModel()
    
    var body: some View {
        ZStack{
            NavigationStack {
                VStack{
                    List{
                        Section("Your Keemespaces") {
                            ForEach(viewModel.createdKeemeSpaces, id: \.keemeId) { keemespace in
                                Section(header: EmptyView()){
                                    NavigationLink(destination: DetailedView(details: keemespace)){
                                        HStack {
                                            if let user = viewModel.user {
                                                if let photoUrlString = user.photoUrl, let photoUrl = URL(string: photoUrlString) {
                                                    AsyncImage(url: photoUrl) { image in
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 30, height: 30)
                                                            .clipShape(Circle())
                                                    } placeholder: {
                                                        Image(systemName: "person.circle")
                                                            .font(.system(size: 30))
                                                            .foregroundColor(.gray)
                                                    }
                                                } else {
                                                    Image(systemName: "person.circle")
                                                        .font(.system(size: 30))
                                                        .foregroundColor(.gray)
                                                }
                                                
                                            }
                                            
                                            VStack(alignment: .leading){
                                                Text(keemespace.sessionName)
                                                    .font(.headline)
                                                Text(keemespace.description)
                                                    .foregroundColor(.gray)
                                                    .font(.caption)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                
                                                Text("Start: \(viewModel.formattedDate(from: keemespace.startTime))")
                                                    .font(.caption)
                                                    .foregroundColor(.purple)
                                                Text("End: \(viewModel.formattedDate(from: keemespace.endTime))")
                                                    .font(.caption)
                                                    .foregroundColor(.purple)

                                            }
                                            
                                            
                                        }
                                    }.swipeActions {
                                        Button("Delete") {
                                            print("Delete")
                                        }
                                        .tint(.red)
                                    }

                                }
                                                                
                            }
                        }
                        
                        Section("Notifications"){
                            ForEach(viewModel.joinRequestsForCreator, id: \.id) { request in
                                HStack{
                                    Text("Join request from: \(request.userID)")
                                    
                                    Spacer()
                                    HStack{
                                        Button(action: {
                                            Task {
                                                    do {
                                                        try await viewModel.respondToJoinRequest(id: request.id, keemeId: request.keemeId , userID: request.userID, status: "accepted")
                                                        print("\(request.status)")
                                                    } catch {
                                                        print("Error accepting join request: \(error)")
                                                    }
                                                }
                                        }, label: {
                                            Text(request.status == "accepted" ? "Accept" : "Accepted")
                                                .foregroundColor(.green)
                                                .cornerRadius(2)
                                            
                                        })
                                        Button(action: {
                                            Task {
                                                    do {
                                                        try await viewModel.respondToJoinRequest(id: request.id, keemeId: request.keemeId , userID: request.userID, status: "rejected")
                                                    } catch {
                                                        print("Error accepting join request: \(error)")
                                                    }
                                                }
                                        }, label: {
                                            Text("Reject")
                                                .foregroundColor(.red)
                                                .cornerRadius(2)
                                        })
                                        
                                    }
                                }.buttonStyle(.bordered)
                                
                                // Add more UI elements to display information about the join request as needed
                                
                                

                                
                            }
                            
                        }
                        
                        
                    } .listStyle(.grouped)
                        .listSectionSpacing(.compact)
                        .task {
                            try? await viewModel.loadCurrentUser()
                            try? await viewModel.fetchCreatedKeemeSpaces()
                            try? await viewModel.fetchAllKeemeSpaces()
                            try? await viewModel.fetchCreatorDetails()
                            try? await viewModel.fetchJoinRequestsForCreator()
                        }
                    
                        .navigationTitle("Schedule")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: CreateKeemespaceView(), label: {
                                    Image(systemName: "plus")
                                        .font(.title)
                                })
                            }
                        }

                }
                        }
            .onAppear(){
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                self.showSignInView = authUser == nil
            }

        }
    }
    
}


struct DetailedView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @StateObject private var fviewModel = FavouriteViewModel()
    @State private var isRequested = false
    @State private var isFavourite = false
    let details: Keemespace
    
    init(details: Keemespace) {
        self.details = details
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                if let creator = viewModel.creatorDetails[details.keemeId] {
                    if let photoUrlString = creator.photoUrl, let photoUrl = URL(string: photoUrlString) {
                        AsyncImage(url: photoUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } placeholder: {
                            Image(systemName: "person.circle")
                                .font(.system(size: 100))
                                .foregroundColor(.gray)
                        }
                    } else {
                        Image(systemName: "person.circle")
                            .font(.system(size: 100))
                            .foregroundColor(.gray)
                    }
                } else {
                    Image(systemName: "person.circle")
                        .font(.system(size: 100))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                if let creator = viewModel.creatorDetails[details.keemeId] {
                    Text("Creator Name: \(creator.userId)")
                        .font(.headline)
                } else {
                    Text("Creator Name: Loading...")
                        .font(.headline)
                }
                Text("Session Name: \(details.sessionName)")
                    .font(.body)
                Text("Description: \(details.description)")
                    .font(.body)
                Text("Start: \(viewModel.formattedDate(from: details.startTime))")
                    .font(.body)
                Text("End: \(viewModel.formattedDate(from: details.endTime))")
                    .font(.body)
                Text("Creator ID: \(details.creatorID)")
                    .font(.body)
                if let user = viewModel.user {
                    if details.creatorID != user.userId {
                        HStack{
                            Button(action: {
                                Task {
                                    do {
                                        // Call the requestToJoin function
                                        try await viewModel.requestToJoin(keemeId: details.keemeId)
                                        isRequested = true
                                    } catch {
                                        // Handle any errors
                                        print("Error requesting to join keemespace: \(error)")
                                    }
                                }
                            }) {
                                Text(isRequested ? "Requested": "Request")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.purple)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                Task {
                                    do {
                                        // Call the requestToJoin function
                                        try await fviewModel.fetchAllFavorites()
                                        isFavourite = !isFavourite
                                    } catch {
                                        // Handle any errors
                                        
                                        print("Error requesting to join keemespace: \(error)")
                                    }
                                }
                                
                            }, label: {
                                HStack{
                                    Text(isFavourite ? "Added to Favourites" : "Add to Favourites")
                                    isFavourite ? Image(systemName: "star.fill").foregroundColor(.yellow) : Image(systemName: "star").foregroundColor(.yellow)
                                }
                            })
                                

                        }
                        

                    }
                }
                
                
            }
            .padding()
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(showSignInView: .constant(false))
        
    }
}




