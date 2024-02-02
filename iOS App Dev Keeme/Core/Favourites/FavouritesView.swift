import SwiftUI

struct FavouritesView: View {
    var body: some View {
        VStack{
            NavigationStack{
                ScrollView {
                    FavouritesHeading()
                }
            }
        }
    }
}

#Preview {
    FavouritesView()
}

