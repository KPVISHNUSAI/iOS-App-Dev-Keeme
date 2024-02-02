import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool =  false
    var body: some View {
        Group {
            if log_Status{
                MainTabView()
            }
            else {
                Logo1()
            }
        }
    }
}
#Preview {
    ContentView()
}

//import SwiftUI
//struct ContentView: View {
//    @State private var showLoginPage = false
//    @State private var showSignup = false
//    @State private var isLoggedIn: Bool = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if !showLoginPage {
//                    Logo()
//                        .onAppear {
//                            // Simulate a delay for the logo display
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                withAnimation {
//                                    showLoginPage = true
//                                }
//                            }
//                        }
//                } else if !showSignup {
//                    LoginPage(showSignup: $showSignup)
//
//                } else {
//                    Signup(showSignup: $showSignup)
//                }
//            }
//
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}



