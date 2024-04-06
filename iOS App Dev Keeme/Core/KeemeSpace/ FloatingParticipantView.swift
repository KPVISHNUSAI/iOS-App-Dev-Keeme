import SwiftUI
import StreamVideo
import StreamVideoSwiftUI
struct FloatingParticipantView: View {

    var participant: CallParticipant?
    var size: CGSize = .init(width: 140, height: 180)

    var body: some View {
        if let participant = participant {
            VStack {
                HStack {
                    Spacer()

                    VideoRendererView(id: participant.id, size: size) { videoRenderer in
                        videoRenderer.handleViewRendering(for: participant, onTrackSizeUpdate: { _, _ in })
                    }
                    .frame(width: size.width, height: size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                Spacer()
            }
            .padding()
        }
    }
}

