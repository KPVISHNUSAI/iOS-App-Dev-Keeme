//
//  UserDetailsForm.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 07/04/24.
//

import Foundation
import SwiftUI


struct UserDetailsFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName = ""
    @State private var lastName = ""
    // Add other necessary fields
    
    var completion: () -> Void
    
    var body: some View {
        VStack {
            Text("User Details Form")
                .font(.title)
                .padding()
            
            TextField("First Name", text: $firstName)
                .padding()
            
            TextField("Last Name", text: $lastName)
                .padding()
            
            // Add other necessary fields
            
            Button("Submit") {
                // Perform form submission action here
                
                // Assuming form submission is successful, call the completion closure
                completion()
                
                // Dismiss the form
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}


#Preview {
    UserDetailsFormView(completion: {})
}
