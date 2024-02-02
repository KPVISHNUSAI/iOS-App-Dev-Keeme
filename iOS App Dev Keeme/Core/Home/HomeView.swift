import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationStack{
                VStack {
                    IntroView()
                    ScrollView {
                        LazyVStack(spacing: -5) {
                            // Your other views
                            HomeScheduleBar()
                            PieChartView()
                            HStack {
                                Text("Find the Buddy")
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                Spacer()
                            }
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .padding()

                            VStack(alignment: .center, content: {
                                let sortedListings = Listing.sampleListings.sorted { $0.time < $1.time }
                                ForEach(sortedListings) { listing in
                                    NavigationLink(destination: BuddyView(listing: listing)) {
                                        Listings(listing: listing)
                                    }
                                }
                            })
                        }
                    }
                }
            }
                
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



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
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
