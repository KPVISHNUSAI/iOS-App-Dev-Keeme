import SwiftUI
import StreamVideo
import StreamVideoSwiftUI


struct VideoCallApp: View {
    @ObservedObject var viewModel:CallViewModel

    private var client: StreamVideo
    private let apiKey: String = "mmhfdzb5evj2" // The API key can be found in the Credentials section
    private let userId: String = "Pre_Vizsla" // The User Id can be found in the Credentials section
    private let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiUHJlX1ZpenNsYSIsImlzcyI6Imh0dHBzOi8vcHJvbnRvLmdldHN0cmVhbS5pbyIsInN1YiI6InVzZXIvUHJlX1ZpenNsYSIsImlhdCI6MTcxMTM1OTM4NiwiZXhwIjoxNzExOTY0MTkxfQ.gmrNyAzFNCYlbW6NIiLtlK985S4S39J-CuAeq082VZU" // The Token can be found in the Credentials section
    private let callId: String = "jQZwek7hMmM8" // The CallId can be found in the Credentials section

    init() {
        let user = User(
            id: userId,
            name: "Martin", // name and imageURL are used in the UI
            imageURL: .init(string: "https://getstream.io/static/2796a305dd07651fcceb4721a94f4505/a3911/martin-mitrevski.webp")
        )

        // Initialize Stream Video client
        self.client = StreamVideo(
            apiKey: apiKey,
            user: user,
            token: .init(stringLiteral: token)
        )

        self.viewModel = .init()
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.call != nil {
                    CallContainer(viewFactory: VideoCallCustomUI(), viewModel: viewModel)
                } else {
                    Text("loading...")
                }
            }
            .onAppear {
                Task {
                    guard viewModel.call == nil else { return }
                    viewModel.joinCall(callType: .default, callId: callId)
                }
            }
        }
    }
}

