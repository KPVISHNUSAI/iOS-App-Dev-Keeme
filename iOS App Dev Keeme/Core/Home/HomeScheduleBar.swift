import SwiftUI

struct HomeScheduleBar: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 2 ){
                Text("Scheduled")
                    .font(.system(size:18,weight: .medium,design: .default))
                Text("Studying with Rita")
                    .font(.system(size:14,weight: .medium,design: .default))
                Text("11:40 am to 12:40 pm")
                    .font(.system(size:16,weight: .medium,design: .default))
                    .foregroundColor(.purpleSet)
            }
            .padding()
            Spacer()
            
            Button(action: {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        window.rootViewController = UIHostingController(rootView: KeemeSpaceView())
                        window.makeKeyAndVisible()
                    }
            }, label: {
                Text("Join Now")
                    .foregroundColor(Color.purpleSet)
                    .underline()
            })
            .padding()
        }
        .frame(height:74)
        .background(Color.greySet)
        .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth:1)
                .foregroundColor(.red)
        }
        .padding()
        Spacer()
    }
}

#Preview {
    HomeScheduleBar()
}
