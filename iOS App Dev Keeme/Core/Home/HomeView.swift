import SwiftUI
import SwiftUICharts

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var createdKeemeSpaces: [Keemespace] = []
    @Published private(set) var allKeemeSpaces: [Keemespace] = []
    
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func togglePremiumStatus() {
        guard let user else {
            return
        }
        //        user.togglePremiumStatus()
        let currentValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func addUserIntrests(text: String) {
        guard let user else { return }
        
        Task{
            try await UserManager.shared.addUserIntrests(userId:user.userId,interest: text)
        }
    }
    
    func removeUserIntrests(text: String) {
        guard let user else { return }
        
        Task{
            try await UserManager.shared.removeUserIntrests(userId:user.userId,interest: text)
        }
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
    
    
    
    func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return formatter.string(from: date)
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
    
    func addToFvourites(userId: String, favoriteUserId: String) async throws {
        try await UserManager.shared.addToFavouriteUsers(userId: userId, favoriteUserId: favoriteUserId)
        try await loadCurrentUser()
    }

    
    
    //    func createNewKeemespace() {
    //
    //        // Example usage
    //        let keemespace = Keemespace(keemeId: "1",
    //                                    sessionName: "Example Session",
    //                                    description: "This is an example session",
    //                                    dateTime: Date(),
    //                                    creatorID: "user123",
    //                                    participants: ["participant1", "participant2"],
    //                                    joinRequests: [JoinRequest(userID: "user456", timestamp: Date(), status: "pending")])
    //
    //
    //
    //        Task {
    //            do {
    //                try await KeemespaceManager.shared.createKeemespace(keemespace: keemespace)
    //            } catch {
    //                // Handle error
    //                print("Error creating Keemespace: \(error.localizedDescription)")
    //            }
    //        }
    //    }
    
    
}


struct HomeView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    @Environment(\.colorScheme) var colorScheme
    @State private var isVideoCall = false
    @State private var isFirstLogin = true
    @State private var showUserDetailsForm = false
    @State private var searchTerm = ""
    let staticContentHeight: CGFloat = 200
    
    let intrestsOptions: [String] = ["Coding", "Maths", "Physics"]
    
    private func intrestIsSelected(text: String) -> Bool {
        viewModel.user?.interests?.contains(text) == true
    }
    
    var body: some View {
        let gradient = LinearGradient(colors: [Color.purpleSet, Color.gray], startPoint: .top, endPoint: .bottom)
        
            if !showSignInView {
                NavigationStack{
                    ZStack {
                        gradient.opacity(0.5).ignoresSafeArea()
                        VStack{
                            HStack{
                                if let user = viewModel.user {
                                    Text("Hello \(user.firstName ?? "Friend")")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    Spacer()
                                    if let photoUrlString = user.photoUrl, let photoUrl = URL(string: photoUrlString) {
                                        AsyncImage(url: photoUrl) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                        } placeholder: {
                                            Image(systemName: "person.circle")
                                                .font(.system(size: 40))
                                                .foregroundColor(.gray)
                                        }
                                    } else {
                                        Image(systemName: "person.circle")
                                            .font(.system(size: 40))
                                            .foregroundColor(.gray)
                                    }
                                    
                                }
                                
                            }
                            .padding()
    //                        .background(Color.purpleSet.opacity(0.5).edgesIgnoringSafeArea(.all))
                            
                            ScrollView{
                                VStack(alignment: .leading){
                                    Text("Upcoming Schedule")
                                        .font(.subheadline)
                                        .fontDesign(.rounded)
                                    if let firstKeemeSpace = viewModel.createdKeemeSpaces.first {
                                         
                                            NavigationLink(destination: DetailedView(details: firstKeemeSpace)){
                                                HStack {
                                                    if let user = viewModel.user {
                                                        if let photoUrlString = user.photoUrl, let photoUrl = URL(string: photoUrlString) {
                                                            AsyncImage(url: photoUrl) { image in
                                                                image
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .frame(width: 30, height: 30)
                                                                    .clipShape(Circle())
                                                                    .padding()
                                                            } placeholder: {
                                                                Image(systemName: "person.circle")
                                                                    .font(.system(size: 30))
                                                                    .foregroundColor(.gray)
                                                                    .padding()
                                                            }
                                                        } else {
                                                            Image(systemName: "person.circle")
                                                                .font(.system(size: 30))
                                                                .foregroundColor(.gray)
                                                                .padding()
                                                        }
                                                        
                                                    }
                                                    
                                                    VStack(alignment: .leading) {
                                                        
                                                        Text(firstKeemeSpace.sessionName)
                                                            .font(.title3)
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.white)
                                                            
                                                        Text(firstKeemeSpace.description)
                                                            .foregroundColor(.white)
                                                            .font(.caption)
                                                            .lineLimit(1)
                                                            .truncationMode(.tail)
                                                            .fontWeight(.bold)
                                                        
                                                        Text("Start: \(viewModel.formattedDate(from: firstKeemeSpace.startTime))")
                                                            .font(.caption)
                                                            .foregroundColor(.white)
                                                            .fontWeight(.bold)
                                                        Text("End: \(viewModel.formattedDate(from: firstKeemeSpace.endTime))")
                                                            .font(.caption)
                                                            .foregroundColor(.white)
                                                            .fontWeight(.bold)
                                                    }
                                                    
        //                                            Button(action: {
        //
        //                                                Task{
        //                                                    do {
        //                                                        KeemeSpaceView(showSignInView: $showSignInView)
        //
        //                                                    } catch {
        //                                                        // Handle any errors
        //                                                        print("Error requesting to join keemespace: \(error)")
        //                                                    }
        //
        //                                                }
        //
        //                                            }, label: {
        //                                                Text("Join Now")
        //                                            })
        //                                            .buttonStyle(.borderedProminent)
        //                                            .background(.purpleSet)
        //                                            .cornerRadius(5)
                                                    Spacer()
                                                    
                                                    Button{
                                                        isVideoCall.toggle()
                                                    }label: {
                                                        Text("Join Now")
                                                            .foregroundColor(.white)
                                                            .fontWeight(.bold)
                                                        
                                                    }.fullScreenCover(isPresented: $isVideoCall, content: VideoCallApp.init)
                                                        .buttonStyle(.borderedProminent)
                                                        
                                                    
                                                    
                                                }
                                                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)) // Adjust padding as needed
                                                .background(Color.purpleSet.opacity(0.5).edgesIgnoringSafeArea(.all))
                                                .cornerRadius(10) // Apply corner radius
                                                .shadow(radius: 5)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.purpleSet, lineWidth: 1) // Adjust the color and width of the border
                                                )
                                                
                                            }

                                    } else {
                                        HStack{
                                            VStack(alignment: .center){
                                                Text("No schedules found")
                                                    .foregroundStyle(.primary)
                                            }
                                            
                                                
                                            Spacer()
                                        }.padding() // Adjust padding as needed
                                            .background(Color.purpleSet.opacity(0.5).edgesIgnoringSafeArea(.all))
                                            .cornerRadius(10) // Apply corner radius
                                            .shadow(radius: 10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.purpleSet.opacity(0.9), lineWidth: 1) // Adjust the color and width of the border
                                                    
                                            )
                                    }
                                        
                                    VStack(alignment: .center) {
                                        let chartData = ChartData(points: [80, 23, 54, 32, 12, 37, 100])
                                        BarChartView(data: chartData, title: "Focus Metrics", style: Styles.barChartStyleNeonBlueDark, form: ChartForm.extraLarge)
                                    }
                                                                        
                                    VStack(alignment: .leading) {
                                        Text("Find the buddy")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            
                                        VStack{
                                            ForEach(viewModel.allKeemeSpaces, id: \.keemeId) { keemespace in
                                                NavigationLink(destination: DetailedView(details: keemespace)){
                                                    HStack{
                                                        
                                                        Circle()
                                                            .fill(.black)
                                                            .frame(width: 40, height: 40)
                                                            .padding()
                                                        
                                                        VStack(alignment: .leading){
                                                            Text(keemespace.sessionName)
                                                                .font(.headline)
                                                                .foregroundColor(.white)
                                                            Text(keemespace.description)
                                                                .foregroundColor(.white)
                                                                .fontWeight(.bold)
                                                                .font(.caption)
                                                                .lineLimit(1)
                                                                .truncationMode(.tail)
                                                            
                                                            Text("Start: \(viewModel.formattedDate(from: keemespace.startTime))")
                                                                .font(.caption)
                                                                .foregroundColor(.white)
                                                            Text("End: \(viewModel.formattedDate(from: keemespace.endTime))")
                                                                .font(.caption)
                                                                .foregroundColor(.white)
                                                        }
                                                        Spacer()
                                                    }.padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)) // Adjust padding as needed
                                                        .background(Color.purpleSet.opacity(0.5).edgesIgnoringSafeArea(.all))
                                                        .cornerRadius(10) // Apply corner radius
                                                        .shadow(radius: 5)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .stroke(Color.purpleSet, lineWidth: 1) // Adjust the color and width of the border
                                                        )
                                                }
                                                
                                            }
                                        }
                                        
                                        
                                    }
                                    
                                                                
                                    
                                    
                            }.task {
                                try? await viewModel.loadCurrentUser()
                                try? await viewModel.fetchCreatedKeemeSpaces()
                                try? await viewModel.fetchAllKeemeSpaces()
                            }
                            .padding()
                            

                            }


                        }
                    }
                    
//                    .background(Color.purpleSet.opacity(0.5).edgesIgnoringSafeArea(.all))
                    
                    
                                        
                                            
                    //                    if let user = viewModel.user {
                    //                        Button(action:{
                    //                            viewModel.togglePremiumStatus()
                    //                        } ,label: {
                    //                            Text("User is Premium: \((user.isPremium ?? false).description.capitalized)")
                    //                        })
                    //                    }
                    
                    //                    VStack {
                    //                        Text("User Intrests")
                    //                        HStack{
                    //                            ForEach(intrestsOptions, id: \.self){ string in
                    //                                Button(string){
                    //                                    if intrestIsSelected(text: string) {
                    //                                        viewModel.removeUserIntrests(text: string)
                    //                                    } else {
                    //                                        viewModel.addUserIntrests(text: string)
                    //                                    }
                    //                                }.font(.headline)
                    //                                    .buttonStyle(.borderedProminent)
                    //                                    .tint(intrestIsSelected(text: string) ? .green : .red)
                    //                            }
                    //
                    //                        }
                    
                    //                        NavigationLink {
                    //                            CreateKeemespaceView()
                    //                        } label : {
                    //                            Text("Create Keemespace")
                    //                                .font(.headline)
                    //                                .foregroundColor(.white)
                    //                                .frame(height: 55)
                    //                                .frame(maxWidth: .infinity)
                    //                                .background(Color.blue)
                    //                                .cornerRadius(10)
                    //                        }
                    //                    }
                    
                }.fullScreenCover(isPresented: $showSignInView){
                    NavigationStack{
                        AuthenticationView(showSignInView: $showSignInView)
                    }
                }
                .fullScreenCover(isPresented: $showUserDetailsForm) {
                    UserDetailsFormView(completion: {
                        // Handle completion of user details form
                        showUserDetailsForm = false
                    })
                }
                .refreshable {
                    try? await viewModel.loadCurrentUser()
                    try? await viewModel.fetchCreatedKeemeSpaces()
                    try? await viewModel.fetchAllKeemeSpaces()
                }
            }
        
        
                
            
            
            
            //        NavigationStack {
            //            VStack {
            //    //            NavigationStack{
            //                    //VStack {
            ////                        IntroView()  // 21-march
            //                        ScrollView {
            //                            LazyVStack(spacing: -5) {
            //                                // Your other views
            ////                                HomeScheduleBar()  // 21-march
            ////                                PieChartView()  // 21-march
            //                                HStack {
            //                                    Text("Find the Buddy")
            //                                        .font(.system(size: 25, weight: .bold, design: .default))
            //                                    Spacer()
            //                                }
            //                                .font(.system(size: 20, weight: .medium, design: .default))
            //                                .padding()
            //
            //                                VStack(alignment: .center, content: {
            ////                                    Listings() // 21-march
            //
            //
            //    //                                let sortedListings = Listing.sampleListings.sorted { $0.time < $1.time }
            //    //                                ForEach(sortedListings) { listing in
            //    //                                    NavigationLink(destination: BuddyView(listing: listing)) {
            //    //                                        Listings(listing: listing)
            //    //                                    }
            //    //                                }
            //                                })
            //                            }
            //                        }
            //                    //}
            //                //}
            //
            //            }
            //        }
            
        }
    }
    
    //#Preview {
    //    let previewVar = Preview()
    //    previewVar.addExamples(User.SampleUserdata)
    //    return HomeView()
    //        .modelContainer(previewVar.container)
    //}
    
    
    
    //import SwiftUI
    //
    //struct HomeView: View {
    //    var body: some View {
    //        VStack {
    //            NavigationView {
    //                VStack {
    //                    IntroView()
    //                    ScrollView {
    //                        LazyVStack(spacing: -5) {
    //                            // Your other views
    //                            HomeScheduleBar()
    //                            PieChartView()
    //                            HStack{
    //                                Text("Find the Buddy")
    //                                    .font(.system(size:25,weight: .bold
    //                                                  ,design: .default))
    //                                Spacer()
    //                            }
    //                            .font(.system(size:20,weight: .medium,design: .default))
    //                            .padding()
    //
    //                            VStack(alignment: .center, content: {
    //                                ForEach(Listing.sampleListings) { listing in
    //                                    NavigationLink(destination: BuddyView(listing: listing)) {
    //                                        Listings(listing: listing)
    //                                    }
    //                                }
    //                            })
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
//}
//






struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showSignInView: .constant(false))
            
    }
}
