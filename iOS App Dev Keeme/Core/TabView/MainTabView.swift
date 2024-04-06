//import SwiftUI
//
//struct MainTabView: View {
//    @State private var selectedTab: Tab = .home
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            HomeView()
//                .tabItem { Label("Home", systemImage: "house") }
//                .tag(Tab.home)
//
//            ScheduleView()
//                .tabItem { Label("Schedule", systemImage: "calendar") }
//                .tag(Tab.schedule)
//
//            FavouritesView()
//                .tabItem { Label("Favourites", systemImage: "star") }
//                .tag(Tab.favourites)
//        }
//        .onAppear {
//            withAnimation {
//                // Customize the animation and foreground color for all tabs to purple
//                switch selectedTab {
//                case .home:
//                    // Animation and color for Home tab
//                    break
//                case .schedule:
//                    // Animation and color for Schedule tab
//                    break
//                case .favourites:
//                    // Animation and color for Favourites tab
//                    break
//                }
//            }
//        }
//        .accentColor(.purple) // Set the accent color for the entire TabView to purple
//    }
//}
//
//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
//
//enum Tab {
//    case home
//    case schedule
//    case favourites
//}
