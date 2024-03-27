import SwiftUI
import SwiftData

struct HomeScheduleBar: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [UserTrail]
    @Query private var keemespace: [KeemeSpace]
    @State private var isVideoCall = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 2 ){
                Text("Scheduled")
                    .font(.system(size:18,weight: .medium,design: .default))
//                                Text("Study with \(users[0].username)")
//                                    .font(.system(size:14,weight: .medium,design: .default))
//                                Text("\(keemespace[0].startTime, style: .time)")
//                                    .font(.system(size:16,weight: .medium,design: .default))
//                                    .foregroundColor(.purpleSet)
                
                
            }
            .padding()
            Spacer()
            Button{
                isVideoCall.toggle()
            }label: {
                Text("Join Now").padding()
            }.fullScreenCover(isPresented: $isVideoCall, content: VideoCallApp.init)
            
//            Button(action: {
////                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
////                       let window = windowScene.windows.first {
////                        window.rootViewController = UIHostingController(rootView: KeemeSpaceView())
////                        window.makeKeyAndVisible()
//                
////                    }
//               // VideoCallApp()
//            }, label: {
//                Text("Join Now")
//                    .foregroundColor(Color.purpleSet)
//                    .underline()
//            })
//            .padding()
        }
        .frame(height:74)
        .background(Color.greySet)
        .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth:1)
                .foregroundColor(.red)
        }
        .padding()
        //Spacer()
    }
}

#Preview {
    HomeScheduleBar()
}
