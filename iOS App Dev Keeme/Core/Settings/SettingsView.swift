////
////  SettingsView.swift
////  KeemeV2
////
////  Created by Gunna Rahul on 14/01/24.
////
//
//import SwiftUI
//
//struct SettingsView: View {
//    @AppStorage("log_Status") var log_Status: Bool = false
//    @State private var isToggleOnForNotifications = false
//    @State private var isToggleOnForAppNotifications = false
//    var body: some View {
////        NavigationStack {
////            VStack{
////                Text("Hello")
////            }
////            .navigationTitle("Settings")
////        }
//        NavigationStack {
//            VStack(alignment:.leading){
//                Text("Settings")
//                    .bold()
//                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                HStack{
//                    Image(systemName: "person")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 20, height: 20)
//                                
//                    Text("Account")
//                        .font(.headline)
//                    Spacer()
//                }
//                Divider()
//                
//                    HStack(){
//                        Text("Edit Profile")
//                        Spacer()
//                        NavigationLink(destination:EditProfileView()){
//                            Image(systemName: "chevron.right")
//                                .font(.title)
//                                .padding()
//                                .background(Color.white)
//                                .foregroundColor(.black)
//                                .clipShape(Circle())
//                        }
//                    }
//                
//                
//                HStack(){
//                    Text("Change Password")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .font(.title)
//                        .padding()
//                        .background(Color.white)
//                        .foregroundColor(.black)
//                        .clipShape(Circle())
//                }
//                HStack{
//                    Image(systemName: "bell")
//                        .resizable()
//                        .font(.title)
//                        .foregroundColor(.black)
//                        .frame(width: 20, height: 20)
//                        .aspectRatio(contentMode: .fit)
//                    Text("Notifications").font(.headline)
//                }
//                Divider()
//                VStack{
//                    Toggle("Notifications",isOn: $isToggleOnForNotifications)
//                        .padding(.bottom,20)
//                    Toggle("App Notifications",isOn: $isToggleOnForAppNotifications)
//                }
//                .padding(.bottom,20)
//                HStack{
//                    Image(systemName: "ellipsis.circle")
//                        .resizable()
//                        .font(.title)
//                        .foregroundColor(.black)
//                        .frame(width: 20, height: 20)
//                    Text("More").font(.headline)
//                }
//                Divider()
//                HStack{
//                    Text("Language")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .font(.title)
//                        .padding()
//                        .background(Color.white)
//                        .foregroundColor(.black)
//                        .clipShape(Circle())
//                }
//                HStack{
//                    Text("Country")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .font(.title)
//                        .padding()
//                        .background(Color.white)
//                        .foregroundColor(.black)
//                        .clipShape(Circle())
//                }
//            }.padding(20)
//            Spacer()
//            VStack(alignment:.center){
//                HStack(alignment: .center){
//                    Button(action: {
//                                // Code to be executed when the button is tapped
//                        log_Status = false
//                                print("Button tapped!")
//                    }) {
//                                Text("Logout")
//                            .foregroundColor(.white)
//                            .font(.system(size:18,weight: .medium,design: .default))
//                            .frame(width:150)
//                            .padding()
//                            .background(.blue2)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .shadow(radius: 10)
//
//                            }
//                }
//            }
//            Spacer()
//
//        }
//            
//        
//            
//
//    }
//}
//
//#Preview {
//    SettingsView()
//}


//import SwiftUI
//
//struct SettingsView: View {
//    @AppStorage("log_Status") var log_Status: Bool = false
//    @State private var isToggleOnForNotifications = false
//    @State private var isToggleOnForAppNotifications = false
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 20) {
//                    NavigationLink(destination: EditProfileView()) {
//                        HStack {
//                            Image(systemName: "person")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 20, height: 20)
//
//                            Text("Account")
//                                .font(.headline)
//
//                            Spacer()
//                        }
//                    }
//                    .foregroundColor(.black)
//
//                    Divider()
//
//                    HStack {
//                        Text("Edit Profile")
//                        Spacer()
//
//                        NavigationLink(destination: EditProfileView()) {
//                            Image(systemName: "chevron.right")
//                                .font(.title)
//                                .padding()
//                                .background(Color.white)
//                                .foregroundColor(.black)
//                                .clipShape(Circle())
//                        }
//                    }
//
//                    HStack {
//                        Text("Change Password")
//                        Spacer()
//
//                        Image(systemName: "chevron.right")
//                            .font(.title)
//                            .padding()
//                            .background(Color.white)
//                            .foregroundColor(.black)
//                            .clipShape(Circle())
//                    }
//
//                    HStack {
//                        Image(systemName: "bell")
//                            .resizable()
//                            .font(.title)
//                            .foregroundColor(.black)
//                            .frame(width: 20, height: 20)
//                            .aspectRatio(contentMode: .fit)
//
//                        Text("Notifications")
//                            .font(.headline)
//                    }
//
//                    Divider()
//
//                    VStack {
//                        Toggle("Notifications", isOn: $isToggleOnForNotifications)
//                            .padding(.bottom, 20)
//
//                        Toggle("App Notifications", isOn: $isToggleOnForAppNotifications)
//                    }
//                    .padding(.bottom, 20)
//
//                    HStack {
//                        Image(systemName: "ellipsis.circle")
//                            .resizable()
//                            .font(.title)
//                            .foregroundColor(.black)
//                            .frame(width: 20, height: 20)
//
//                        Text("More")
//                            .font(.headline)
//                    }
//
//                    Divider()
//
//                    HStack {
//                        Text("Language")
//                        Spacer()
//
//                        Image(systemName: "chevron.right")
//                            .font(.title)
//                            .padding()
//                            .background(Color.white)
//                            .foregroundColor(.black)
//                            .clipShape(Circle())
//                    }
//
//                    HStack {
//                        Text("Country")
//                        Spacer()
//
//                        Image(systemName: "chevron.right")
//                            .font(.title)
//                            .padding()
//                            .background(Color.white)
//                            .foregroundColor(.black)
//                            .clipShape(Circle())
//                    }
//                }
//                .padding(20)
//                
//                VStack(alignment: .center) {
//                    Button(action: {
//                        // Code to be executed when the button is tapped
//                        log_Status = false
//                        print("Button tapped!")
//                    }) {
//                        Text("Logout")
//                            .foregroundColor(.white)
//                            .font(.system(size: 18, weight: .medium, design: .default))
//                            .frame(width: 150)
//                            .padding()
//                            .background(Color.blue)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .shadow(radius: 10)
//                    }
//                }
//                .padding()
//            }
//            .navigationBarTitle("Settings", displayMode: .automatic)
//
//            
//        }
//    }
//}
//
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
//


//import SwiftUI
//
//struct SettingsView: View {
//    @AppStorage("log_Status") var log_Status: Bool = false
//    @State private var isToggleOnForNotifications = false
//    @State private var isToggleOnForAppNotifications = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Account")) {
//                    NavigationLink(destination: EditProfileView()) {
//                        HStack {
//                            Image(systemName: "person")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 20, height: 20)
//
//                            Text("Edit Profile")
//                        }
//                    }
//                }
//
//                Section(header: Text("Security")) {
//                    NavigationLink(destination: ChangePasswordView()) {
//                        HStack {
//                            Image(systemName: "lock")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 20, height: 20)
//
//                            Text("Change Password")
//                        }
//                    }
//                }
//
//                Section(header: Text("Notifications")) {
//                    Toggle("Notifications", isOn: $isToggleOnForNotifications)
//                    Toggle("App Notifications", isOn: $isToggleOnForAppNotifications)
//                }
//
//                Section(header: Text("Preferences")) {
//                    NavigationLink(destination: EmptyView()) {
//                        HStack {
//                            Text("Language")
//                        }
//                    }
//                    NavigationLink(destination: EmptyView()) {
//                        HStack {
//                            Text("Country")
//                        }
//                    }
//                }
//
//                Section {
//                    Button(action: {
//                        // Code to be executed when the button is tapped
//                        log_Status = false
//                        print("Logout button tapped!")
//                    }) {
//                        Text("Logout")
//                            .foregroundColor(.white)
//                            .font(.system(size: 18, weight: .medium, design: .default))
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .shadow(radius: 10)
//                    }
//                }
//            }
//            .navigationBarTitle("Settings", displayMode: .automatic)
//        }
//    }
//}
//
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}

import SwiftUI
import PhotosUI

struct SettingsView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    @State private var isToggleOnForNotifications = false
    @State private var isToggleOnForAppNotifications = false
    @State private var userProfile = UserProfile()
//    @State private var country = ""
//    let countryCodes = Locale.Region.isoRegions
//
//        // Get the localized name for each country code
//        let countryNames = Locale.Region.isoRegions.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Account")) {
                    NavigationLink(destination: EditProfile(userProfile: $userProfile)) {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)

                            Text("Edit Profile")
                        }
                    }
                }

                Section(header: Text("Security")) {
                    NavigationLink(destination: ChangePassword(userProfile: $userProfile)) {
                        HStack {
                            Image(systemName: "lock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)

                            Text("Change Password")
                        }
                    }
                }

                Section(header: Text("Notifications")) {
                    Toggle("Notifications", isOn: $isToggleOnForNotifications)
                }

                Section(header: Text("Preferences")) {
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Text("Language")
                        }
                    }
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Picker("Country", selection:$userProfile.address.country){
                                ForEach(NSLocale.isoCountryCodes, id:\.self){
                                    countryCode in
                                    Text(Locale.current.localizedString(forRegionCode: countryCode) ?? "")
                                }
                            }
                        }
                    }
                }

                Section {
                    Button(action: {
                        // Code to be executed when the button is tapped
                        log_Status = false
                        print("Logout button tapped!")
                    }) {
                        Text("Logout")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 10)
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .automatic)
        }
    }
}


struct EditProfile: View {
    @State private var isEditing = false
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var avatarImage: UIImage?
    @Binding var userProfile: UserProfile

    var body: some View {
        Form {
            Section {

                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Spacer()

                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            Image(uiImage: (avatarImage ?? userProfile.profileImage ?? UIImage()))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        }
                        .disabled(!isEditing)
                        .onChange(of: photosPickerItem, perform: { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let image = UIImage(data: data) {
                                    avatarImage = image
                                }
                            }
                        })

                        Spacer()
                    }
                }

                VStack(alignment: .leading) {
                        Text("About Me")
                            .foregroundColor(.gray)
                        TextEditor(text: $userProfile.biography)
                            .disabled(!isEditing)
                            .frame(minHeight: 100)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                            .padding(.vertical, 8)
                }
            
                HStack {
                    Text("First Name:")
                        .foregroundColor(.gray)
                    TextField("First Name", text: $userProfile.firstName)
                        .disabled(!isEditing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .autocapitalization(.words)
                }

                HStack {
                    Text("Last Name:")
                        .foregroundColor(.gray)
                    TextField("Last Name", text: $userProfile.lastName)
                        .disabled(!isEditing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .autocapitalization(.words)
                }

                HStack {
                    Text("Date of Birth:")
                        .foregroundColor(.gray)
                    DatePicker("Date of Birth", selection: $userProfile.dateOfBirth, displayedComponents: .date)
                        .disabled(!isEditing)
                        .labelsHidden()
                }

                
                HStack {
                    Text("Gender:")
                        .foregroundColor(.gray)
                    Picker("Gender", selection: $userProfile.gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue)
                            }
                        }
                        .disabled(!isEditing)
                        .labelsHidden()
                }

                HStack {
                    Text("Phone Number:")
                        .foregroundColor(.gray)
                    TextField("Phone Number", text: $userProfile.phoneNumber)
                        .disabled(!isEditing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .keyboardType(.phonePad)
                }

                HStack {
                    Text("School/University:")
                        .foregroundColor(.gray)
                    TextField("School/University Name", text: $userProfile.education.schoolName)
                        .disabled(!isEditing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .autocapitalization(.words)
                }

                HStack {
                    Text("Degree:")
                        .foregroundColor(.gray)
                    TextField("Degree", text: $userProfile.education.degree)
                        .disabled(!isEditing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .autocapitalization(.words)
                }

                HStack {
                    Text("Major:")
                        .foregroundColor(.gray)
                    TextField("Major", text: $userProfile.education.major)
                        .disabled(!isEditing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .autocapitalization(.words)
                }

                HStack {
                    Text("LinkedIn Profile:")
                        .foregroundColor(.gray)
                    TextField("LinkedIn Profile", text: $userProfile.linkedinProfile)
                        .disabled(!isEditing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        
                }
            }

            Section {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Save" : "Edit Profile")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 10)
                }
            }
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
    }
}


struct ChangePassword: View {
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @Binding var userProfile: UserProfile
    @State private var isEditing = false

    var body: some View {
        Form {
            Section(header: Text("Current Password")) {
                SecureField("Enter your current password", text: $currentPassword)
            }

            Section(header: Text("New Password")) {
                SecureField("Enter your new password", text: $newPassword)
            }

            Section(header: Text("Confirm Password")) {
                SecureField("Confirm your new password", text: $confirmPassword)
            }

            Section {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Change Password" : "Save")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 10)
                }
            }
        }
        .navigationBarTitle("Change Password", displayMode: .inline)
    }
}


struct YearPickerStyle: DatePickerStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            DatePicker("", selection: Binding(
                get: { configuration.$selection.wrappedValue },
                set: { newDate in
                    configuration.$selection.wrappedValue = newDate
                    // Handle the new date as needed
                }
            ))
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
