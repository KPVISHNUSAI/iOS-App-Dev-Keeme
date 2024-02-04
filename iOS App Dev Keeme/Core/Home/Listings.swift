import SwiftUI

struct Listings: View {
    let listing: Listing
    //var list:User
    var body: some View {
        VStack(spacing: -50) {
            HStack {
                Image(listing.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack {
                    Text(listing.name)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                    Text(listing.description)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                    Text(listing.time)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.purpleSet)
                }
            }
            .padding()
            .frame(height: 74)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1).opacity(0.2)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
        }
    }
}

struct Listings_Previews: PreviewProvider {
    static var previews: some View {
        Listings(listing: Listing.sampleListings[0])
    }
}

