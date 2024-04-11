//
//  VideoCallCustomUI.swift
//  iOS App Dev Keeme
//
//  Created by user2 on 24/03/24.
//

import SwiftUI
import StreamVideo
import StreamVideoSwiftUI


class VideoCallCustomUI: ViewFactory {
   
    public func makeCallControlsView(viewModel: CallViewModel) -> some View {
        FBCallControlsView(viewModel: viewModel)
        //CustomCallControlsView(viewModel: viewModel)
    }
    

    }



struct FBCallControlsView: View {
    @State private var achievementsTabOpened = false
    @ObservedObject var viewModel: CallViewModel
    
    var body: some View {
        HStack(spacing: 24) {
            Button {
                viewModel.toggleCameraEnabled()
            } label: {
                Image(systemName: "video.fill")
            }
            
            Spacer()

            Button {
                viewModel.toggleMicrophoneEnabled()
            } label: {
                Image(systemName: "mic.fill")
            }
            
            Spacer()
                        
            Button {
                viewModel.toggleCameraPosition()
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
            }
            
            Spacer()
            
//            if !achievementsTabOpened {
//                ControlButton(systemName: "trophy.fill") {
//                    // Achievements button action
//                    self.achievementsTabOpened.toggle()
//                }
//            }
//            Spacer()
            
            HangUpIconView(viewModel: viewModel)
            
//            AchievementsMenu(width: UIScreen.main.bounds.width / 1.33, achievementsTabOpened: $achievementsTabOpened)
        }
        .foregroundColor(.white)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .modifier(BackgroundModifier())
        .padding(.horizontal, 32)
    }
    
}
struct BackgroundModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 15, *) {
            content
                .background(
                    .ultraThinMaterial,
                    in: RoundedRectangle(cornerRadius: 24)
                )
        } else {
            content
                .background(Color.black.opacity(0.8))
                .cornerRadius(24)
        }
    }
    
}
