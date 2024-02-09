
import SwiftUI
import SwiftData

struct ScheduleData: Codable {
    let myTask: String
    let selectedDate: Date
    let startTime: Date
    let endTime: Date
    let partnerType: String
}

struct ArrangeSchedule: View {
    let yourPreferences = ["Favourites", "Anyone"]
    @State private var myTask = ""
    @State private var selectedDate: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var partnerType: String = "Favourites"
    @State private var isHovered = false
    @State private var minimumDate: Date = Date()
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Meeting.startTime) private var meetings: [Meeting]
    @Environment(\.dismiss) var dismiss
    
    let hours = Array(0...24)
    let minutes = Array(0...59)

    var body: some View {
        Form {
            Section {
                VStack {
                    HStack{
                        Text("Task:")
                                .foregroundColor(.black)
                                .padding(.trailing, 8)
                        Spacer()
                        TextField("Enter your task", text: $myTask)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .padding([.leading, .trailing], 10) // Add padding to the leading and trailing edges
                            .disableAutocorrection(true)
                    }
                    

                    DatePicker("Starts at", selection: $startTime, in: minimumDate..., displayedComponents: [.date, .hourAndMinute])
                        .onChange(of: startTime) { newValue in
                            // Automatically set "Ends at" 1 hour after "Starts at"
                            self.endTime = Calendar.current.date(byAdding: .hour, value: 1, to: newValue) ?? Date()
                        }
                    
                    DatePicker("Ends at", selection: $endTime, in: minimumDate..., displayedComponents: [.date, .hourAndMinute])
                        .onChange(of: endTime) { newValue in
                            // Calculate minimum allowed end time
                            let minimumEndTime = Calendar.current.date(byAdding: .minute, value: 30, to: startTime) ?? Date()

                            // Adjust end time if it's too early
                            if newValue < minimumEndTime {
                                self.endTime = minimumEndTime
                            }
                        }
                }
            }

            Section(header: Text("What type of buddy would you prefer?")) {
                Picker("What type of partner you prefer", selection: $partnerType) {
                    ForEach(yourPreferences, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onAppear {
                    // Set text colors for selected and unselected segments
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
                    UISegmentedControl.appearance().selectedSegmentTintColor = .purple
                }

                Button(action: {
//                    let scheduleData = ScheduleData(
//                        myTask: myTask,
//                        selectedDate: selectedDate,
//                        startTime: startTime,
//                        endTime: endTime,
//                        partnerType: partnerType
//                    )
//                    sendScheduleData(scheduleData)
                    let meetingData = Meeting(
                        meetingID: 2,
                        task: myTask,
                        startTime: startTime,
                        endTime: endTime, // Adding 1 hour to the start time
                        creatorID: 2,
                        preference: partnerType,
                        creator: Student(studentID: 2, emailID: "creator@example.com", password: "password123", firstName: "Jane", lastName: "Doe", meetings: [], favoritedBy: [], favoritedMeetings: [])
                    )
                    context.insert(meetingData)
                    dismiss()
                    
                    
                    
                    

                }) {
                    HStack {
                        Image(systemName: "person.crop.square.badge.video.fill")
                        Text("Create KSpace")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purpleSet)
                    .cornerRadius(8)
                }
                 .onHover { hovering in
                     isHovered = hovering
                 }
            }
        }
        .navigationTitle("Add Schedule")
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
    }

    func sendScheduleData(_ scheduleData: ScheduleData) {
        // Implement your data sending logic here, e.g., using a networking library
        print("Sending schedule data:", scheduleData) // Example placeholder
    }
}

struct ArrangeSchedule_Previews: PreviewProvider {
    static var previews: some View {
        ArrangeSchedule()
    }
}
