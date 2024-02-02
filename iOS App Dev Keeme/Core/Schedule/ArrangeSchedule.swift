//import SwiftUI
//
//struct ArrangeSchedule: View {
//    let yourPreferences = ["Favourites", "Anyone"]
//    @State private var myTask = ""
//    @State private var selectedDate : Date = Date()
//    @State private var isDatePickerVisible = false
//    @State private var selectedTime = Date()
//    @State private var isTimePickerVisible = false
//    @State private var selectedHoursIndex = 0
//    @State private var selectedMinutesIndex = 0
//    @State private var selectedButton: Int?
//    @State private var startTime: Date = Date()
//    @State private var endTime: Date = Date()
//    @State private var partnerType: String = "Favourites"
//    @State private var isHovered = false
//    
//    let hours = Array(0...24)
//    let minutes = Array(0...59)
//    
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    HStack{
//                        Text("My Task").padding(.trailing,10)
//                        TextField("Enter your task", text: $myTask)
//                    }
//                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
//                    DatePicker("Starts at", selection: $startTime, displayedComponents: .hourAndMinute)
//                    DatePicker("Ends at", selection: $endTime, displayedComponents: .hourAndMinute)
//                }
//                
//                Section(header: Text("What type of buddy would you prefer?")) {
//                    Picker("What type of partner you prefer", selection: $partnerType) {
//                        ForEach(yourPreferences, id: \.self) {
//                            Text($0)
//                        }
//                                            }
//                    .pickerStyle(SegmentedPickerStyle())
//                    
//                    Button(action: {
//                        //action 
//                        
//                            }) {
//                                HStack{
//                                    Image(systemName: "person.crop.square.badge.video.fill")
//                                    Text("Create KSpace")
//                                }
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.purpleSet)
//                                .cornerRadius(8)
//                            }
//                            .onHover { hovering in
//                                        isHovered = hovering
//                                    }
//
//                }
//            }
//            Spacer()
//            .navigationTitle("Add Schedule")
//        }
//
//        
//        
////        VStack {
////            HStack{
////                Text("Add Schedule")
////                    .font(.system(size:25,weight: .medium,design: .default))
////                    .padding()
////                     Spacer()  }
////            VStack {
////                
////                TextField("My Task",text:$myTask)
////                    .padding()
////                    .frame(minWidth:360,maxWidth:.infinity)
////                    .background(Color.black.opacity(0.05))
////                    .cornerRadius(10)
////                    .padding(.bottom,15)
////                
////                TextField(selectedDate == nil ? "Select Date" : "", text: Binding(
////                    get: {
////                        selectedDate.map { DateFormatter.localizedString(from: $0, dateStyle: .short, timeStyle: .none) } ?? ""
////                    },
////                    set: { newValue in
////                        // Handle setting the date if needed
////                    }
////                ))
////                .onTapGesture {
////                    // Show the DatePicker when the text field is tapped
////                    isDatePickerVisible.toggle()
////                }
////                .padding()
////                .frame(width:360,height:55)
////                .background(Color.black.opacity(0.05))
////                .cornerRadius(10)
////                .padding(.bottom,15)
////                
////                
////                if isDatePickerVisible {
////                    DatePicker("", selection: Binding(
////                        get: { selectedDate ?? Date() },
////                        set: { selectedDate = $0 }
////                    ), displayedComponents: .date)
////                    .labelsHidden()
////                    .datePickerStyle(WheelDatePickerStyle())
////                    .onTapGesture {
////                        // Hide the DatePicker when tapped outside
////                        isDatePickerVisible.toggle()
////                    }
////                    .transition(.opacity)
////                }
////                
////                
////                TextField("Select Start Time", text: .constant(""))
////                
////                    .onTapGesture {
////                        // Show the TimePicker when the text field is tapped
////                        isTimePickerVisible.toggle()
////                    }
////                    .padding()
////                    .frame(width:360,height:55)
////                    .background(Color.black.opacity(0.05))
////                    .cornerRadius(10)
////                    .padding(.bottom)
////                
////                
////                if isTimePickerVisible {
////                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
////                        .labelsHidden()
////                        .datePickerStyle(WheelDatePickerStyle())
////                        .onTapGesture {
////                            // Hide the TimePicker when tapped outside
////                            isTimePickerVisible.toggle()
////                        }
////                        .transition(.opacity)
////                }
////                
////                TextField("Select Duration", text: .constant(""))
////                    .pickerStyle(MenuPickerStyle())
////                    .padding()
////                    .frame(width:360,height:55)
////                    .background(Color.black.opacity(0.05))
////                    .cornerRadius(10)
////                    .padding(.bottom,15)
////            }.padding()
////            HStack{
////                Text("Prefer Buddy view")
////                    .font(.system(size:25,weight: .medium,design: .default))
////                    .padding()
////                Spacer()
////            }
////
////            HStack {
////                        Button(action: {
////                            self.selectedButton = 1
////                        }) {
////                            Text("Favourites ⭐️")
////                                .padding()
////                                .foregroundColor(selectedButton == 1 ? .white : .black)
////                                .frame(width: 150, height: 50)
////                                .background(selectedButton == 1 ? Color.blue2 : Color.clear)
////                                .border(Color.purple)
////                        }
////    
////
////                        Button(action: {
////                            self.selectedButton = 2
////                        }) {
////                            Text("Anyone 🌐")
////                                .padding()
////                                .foregroundColor(selectedButton == 2 ? .white : .black)
////                                .frame(width: 150, height: 50)
////                                .background(selectedButton == 2 ? Color.blue2 : Color.clear)
////                                .border(Color.purple)
////                        }
////                    }
////                    .padding(.horizontal)
////                    .padding(.bottom,20)
////            HStack{
////                Button(action: {
////                                   // Add action for button tap
////                }) {
////                    Text("Create Keeme Space")
////                        .font(.system(size:18,weight: .medium,design: .default))
////                      //.padding()
////                       //.frame(width: 220, height: 50)
////                      //.background(.blue)
////                        //.border(Color.black)
////                        .frame(height: 30)
////                        .padding()
////                        .background(.blue2)
////                        .clipShape(RoundedRectangle(cornerRadius: 8))
////                        .shadow(radius: 10)
////                        .padding()
////                    
////                }
////                .foregroundColor(.white)
////                
////            }
////            
////        }
////        Spacer()
////        
//    }
//}
//
//extension Color {
//    init(hex: Int) {
//        self.init(
//            .sRGB,
//            red: Double((hex >> 16) & 0xff) / 255,
//            green: Double((hex >> 8) & 0xff) / 255,
//            blue: Double(hex & 0xff) / 255,
//            opacity: 1
//        )
//    }
//}
//
//#Preview {
//    ArrangeSchedule()
//}


import SwiftUI
import SwiftUIIntrospect

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

    let hours = Array(0...24)
    let minutes = Array(0...59)

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack{
                        TextField("Enter your task", text: $myTask)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                        DatePicker("Select Date", selection: $selectedDate, in: minimumDate..., displayedComponents: .date)
                            .onChange(of: selectedDate) { newValue in
                                    if newValue < minimumDate {
                                        self.selectedDate = minimumDate
                                    }
                                }
                        
                        DatePicker("Starts at", selection: $startTime, in: Date()..., displayedComponents: .hourAndMinute)

                        DatePicker("Ends at", selection: $endTime, displayedComponents: .hourAndMinute)
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
                        UISegmentedControl.appearance().selectedSegmentTintColor = .purpleSet
                    }

                    

                    Button(action: {
                        let scheduleData = ScheduleData(
                            myTask: myTask,
                            selectedDate: selectedDate,
                            startTime: startTime,
                            endTime: endTime,
                            partnerType: partnerType
                        )
                        sendScheduleData(scheduleData)
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
            Spacer()
            .navigationTitle("Add Schedule")
        }
    }

    func sendScheduleData(_ scheduleData: ScheduleData) {
        // Implement your data sending logic here, e.g., using a networking library
        print("Sending schedule data:", scheduleData) // Example placeholder
    }
}



struct ArrangeSchedule_Previews: PreviewProvider {
    static var previews: some View {
        ArrangeSchedule() // Use the default initializer
    }
}

