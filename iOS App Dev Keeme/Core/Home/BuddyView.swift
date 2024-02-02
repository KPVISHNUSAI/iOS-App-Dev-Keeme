import SwiftUI

struct BuddyView: View {
    let listing: Listing
        @State private var isSlotBooked = false
    var body: some View {
        ScrollView {
            HStack {
                Image(listing.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 175, height: 175)
                    .clipShape(Circle())
                    .padding()
            }

            HStack {
                Text(listing.name)
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .padding()
            }

            HStack {
                Button(action: {}, label: {
                    Text("Add to Favorites")
                    Image(systemName: "star.fill")
                })
                .padding()
            }
            .frame(height: 40)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
            }

            VStack {
                VStack {
                    Text("Today's Goal")
                        .font(.headline)
                        .frame(width: 300, alignment: .leading)

                    Text(listing.description)
                        .font(.caption)
                        .frame(width: 300, alignment: .leading)
                }
                .padding()

                HStack {
                    Button(action: {
                        // Toggle the booking status
                        isSlotBooked.toggle()
                    }) {
                        if isSlotBooked {
                            Text("Booked")
                        } else {
                            Text("Book the Slot")
                        }
                    }
                }

                HStack {
                    Text("or")
                }

                HStack {
                    Button(action: {}, label: {
                        Text("Chat with")
                    })
                }
            }
            .frame(height: 150)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 10)
            .padding()
        }
    }
}

struct BuddyView_Previews: PreviewProvider {
    static var previews: some View {
        BuddyView(listing: Listing.sampleListings[0])
    }
}
