import SwiftUI
import UIKit

@MainActor
final class KeemespaceModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}


struct CreateKeemespaceView: View {
    @State private var sessionName = ""
    @State private var description = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    @StateObject private var keemespaceModel = KeemespaceModel()
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    let gradient = LinearGradient(colors: [Color.purpleSet, Color.gray], startPoint: .top, endPoint: .bottom)
    var body: some View {
        
            ZStack{
                gradient.opacity(0.5).ignoresSafeArea()
                
                    
                        VStack{
                                TextField("Session Name", text: $sessionName)
                                .padding()
                                .background(colorScheme == .dark ? Color.white.opacity(0.8) : Color.gray.opacity(0.8))
                                .cornerRadius(10)
                                .foregroundColor(Color.primary)
                                
                                TextField("Description", text: $description)
                                .padding()
                                .background(colorScheme == .dark ? Color.white.opacity(0.8) : Color.gray.opacity(0.8))
                                .cornerRadius(10)
                                .foregroundColor(Color.primary)
                                
                                DatePicker("Date and Time", selection: $startTime, displayedComponents: [.date, .hourAndMinute])
                                
                                .cornerRadius(10)
                                .foregroundColor(Color.primary)
                                DatePicker("Date and Time", selection: $endTime, displayedComponents: [.date, .hourAndMinute])
                                
                                .cornerRadius(10)
                                .foregroundColor(Color.primary)
                                Button("Create Keemespace") {
                                    createKeemespace()
                                }.padding()
                                .buttonStyle(.borderedProminent)
                            Spacer()
                        }.padding()
                        

                    
                    
                    
                                        
                
            }
                .navigationTitle("Create Keemespace")
                .onAppear {
                    Task {
                        // Load current user
                        try? await keemespaceModel.loadCurrentUser()
                    }
                }

            
        
        
            
        
    }
    
    func createKeemespace() {
        guard !sessionName.isEmpty, !description.isEmpty else {
            // Handle empty fields error
            return
        }
        
        guard let userID = keemespaceModel.user?.userId else {
            // Handle user ID not found
            return
        }
        
        let keemespace = Keemespace(keemeId: UUID().uuidString,
                                    sessionName: sessionName,
                                    description: description,
                                    startTime: startTime,
                                    endTime: endTime,
                                    creatorID: userID,
                                    participants: [],
                                    joinRequests: [])
        
        Task {
            do {
                try await KeemespaceManager.shared.createKeemespace(keemespace: keemespace)
//                presentationMode.wrappedValue.dismiss()
            } catch {
                // Handle error
                print("Error creating Keemespace: \(error.localizedDescription)")
            }
        }
    }
}

