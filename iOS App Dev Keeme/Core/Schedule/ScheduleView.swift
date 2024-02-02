import SwiftUI

struct ScheduleView: View {
    var body: some View {
            VStack{
                NavigationStack{
                    ScrollView {
                        LazyVStack(spacing: 12){
                            ScheduleHeading()
                        }
                    }
                    .overlay(alignment: .bottomTrailing, content: {
                        Button(action: {
                            // Add your button action here
                        })  {
                            NavigationLink(destination: ArrangeSchedule()){
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 50) // Adjust the size as needed
                                    .foregroundColor(.black) // Adjust the color as needed
                            }
                        }
                        
                        .padding()
                    })
                }
            }
                 //   ScheduleHeading()
                }
            }
            
            

#Preview {
    ScheduleHeading()
}

//import SwiftUI
//
//struct UserModel: Identifiable {
//    let id: String = UUID().uuidString
//    let displayName: String
//    let userName: String
//    let isFavourite: Bool
//    let date: Date
//
//    // Function to generate random dates and times
//    static func randomDate() -> Date {
//        let randomDaysAgo = Int.random(in: 1...10)
//        let randomHoursAgo = Int.random(in: 1...24)
//        return Calendar.current.date(byAdding: .hour, value: -randomHoursAgo, to: Calendar.current.date(byAdding: .day, value: -randomDaysAgo, to: Date())!)!
//    }
//}
//
//struct ScheduleView: View {
//    @State var users: [UserModel] = [
//        UserModel(displayName: "Nick", userName: "nick123", isFavourite: true, date: UserModel.randomDate()),
//        UserModel(displayName: "John", userName: "john456", isFavourite: false, date: UserModel.randomDate()),
//        UserModel(displayName: "Alice", userName: "alice789", isFavourite: true, date: UserModel.randomDate())
//    ]
//    @State private var isShowingArrangeSchedule = false // Add this state variable
//
//
//    var body: some View {
//        VStack {
//            NavigationStack {
//                List {
//                    ForEach(users) { user in
//                        Section(header: EmptyView()) {
//                            HStack(spacing: 15) {
//                                Circle()
//                                    .frame(width: 45, height: 45)
//                                VStack(alignment: .leading) {
//                                    HStack(alignment:.center){
//                                        Text(user.displayName)
//                                            .font(.headline)
//                                        if (user.isFavourite) {
//                                            Image(systemName: "star.fill")
//                                                .foregroundColor(.yellow)
//                                        }
//                                    }
//                                    Text("@\(user.userName)")
//                                        .foregroundColor(.gray)
//                                        .font(.caption)
//                                    Text("\(user.date, style: .date) \(user.date, style: .time)")
//                                        .font(.caption)
//                                }
//                                Spacer()
//                                
//                                Button(action: {
//                                    isShowingArrangeSchedule = true
//                                }) {
//                                    Image(systemName: "arrowshape.right.circle.fill")
//                                        .foregroundColor(.blue)
//                                }.background(
//                                    NavigationLink (
//                                    destination: ArrangeSchedule(),
//                                    isActive: $isShowingArrangeSchedule,
//                                    label: { EmptyView() }
//                                    )
//                                .hidden()
//                            )
//                                
//                                
//                            }
//
//                        }
//                    }.onDelete(perform: delete)
//                }
//                .listStyle(InsetGroupedListStyle())
//                .listSectionSpacing(.compact)
//                .navigationTitle("Schedule")
//                .navigationBarItems(leading: EditButton())
//            }
//        }.overlay(alignment: .bottomTrailing, content: {
//            Button(action: {
//                // Add your button action here
//            })  {
//                NavigationLink(destination: ArrangeSchedule()){
//                    Image(systemName: "plus.circle")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 70, height: 50) // Adjust the size as needed
//                        .foregroundColor(.black) // Adjust the color as needed
//                }
//            }
//            
//            .padding()
//        })
//    }
//    func delete(indexSet: IndexSet){
//        users.remove(atOffsets: indexSet)
//    }
//}
//
//struct ScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleView()
//    }
//}

