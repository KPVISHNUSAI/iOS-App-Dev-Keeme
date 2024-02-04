
import SwiftUI
import SwiftUIIntrospect

struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    let displayName: String
    let userName: String
    let taskDescription: String
    let isFavourite: Bool
    let date: Date

    // Function to generate random dates and times
    static func randomDate() -> Date {
        let randomDaysAgo = Int.random(in: 1...10)
        let randomHoursAgo = Int.random(in: 1...24)
        return Calendar.current.date(byAdding: .hour, value: -randomHoursAgo, to: Calendar.current.date(byAdding: .day, value: -randomDaysAgo, to: Date())!)!
    }
}

struct ScheduleView: View {
    @State var users: [UserModel] = [
        UserModel(displayName: "Rita", userName: "rita123", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: true, date: UserModel.randomDate()),
        UserModel(displayName: "John", userName: "john456", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: false, date: UserModel.randomDate()),
        UserModel(displayName: "Alice", userName: "alice789", taskDescription: "Today I am starting to organize my notes in notion", isFavourite: true, date: UserModel.randomDate())
    ]
    @State private var isAddScheduleViewPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(users) { user in
                        Section(header: EmptyView()) {
                            HStack(spacing: 15) {
                                Circle()
                                    .frame(width: 40, height: 40)
                                VStack(alignment: .leading) {
                                    HStack(alignment:.center){
                                        Text(user.displayName)
                                            .font(.headline)
                                        if (user.isFavourite) {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                    Text(user.taskDescription)
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                    Text("\(user.date, style: .date) \(user.date, style: .time)")
                                        .font(.caption)
                                        .foregroundColor(.purpleSet)
                                        .bold()
                                    
                                }
                                Spacer()
                                
                                Button(action: {
                                    isAddScheduleViewPresented.toggle()
                                }) {
                                    Image(systemName: "arrowshape.right.circle.fill")
                                        .foregroundColor(.blue)
                                }
                                
                                
                            }

                        }
                    }.onDelete(perform: delete)
                    
                    
                }
                .listStyle(.insetGrouped)
                .listSectionSpacing(.compact)
                .navigationTitle("Schedule")
                
                
            }
            .overlay(
                HStack{
                    NavigationLink(destination: ArrangeSchedule(), label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(Circle().fill(Color.purpleSet))
                            .foregroundColor(.white)

                    })
                }.padding(), alignment: .bottomTrailing
            )
        }

    }
    func delete(indexSet: IndexSet){
        users.remove(atOffsets: indexSet)
    }
}



struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}




