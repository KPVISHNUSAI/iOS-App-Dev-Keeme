
import SwiftUI

struct FavouritesHeading: View {
    @State private var searchText = ""
    var body: some View {
        VStack{
            HStack{
                Text("Favourites")
                    .font(.system(size:25,weight: .medium,design: .default))
                    .padding()
                Image(systemName:"star.fill")
                Spacer()
                Image("lauren")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                    .padding()
            }
            HStack{
                
                // Search bar
                TextField("Search", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                
                Divider()
                
                HStack{
                    Image("shelly")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                    VStack{
                        Text("Shelly")
                            .font(.headline)
                            .frame(width: 300,alignment: .leading)
                        Text("I am still stuck at same point")
                            .font(.caption)
                            .frame(width: 300,alignment: .leading)
                    }
                    .foregroundColor(.black)
                }
                
                Divider()
                
                HStack{
                    Image("henry")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                    VStack{
                        Text("Henry")
                            .font(.headline)
                            .frame(width: 300,alignment: .leading)
                        Text("How you doing, mate?")
                            .font(.caption)
                            .frame(width: 300,alignment: .leading)
                    }
                    .foregroundColor(.black)
                }
                
                Divider()
                
                HStack{
                    Image("kyle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                    VStack{
                        Text("Kyle")
                            .font(.headline)
                            .frame(width: 300,alignment: .leading)
                        Text("Hello")
                            .font(.caption)
                            .frame(width: 300,alignment: .leading)
                    }
                    .foregroundColor(.black)
                }
                Divider()
                
            }
        }
    }
#Preview {
    FavouritesHeading()
}

