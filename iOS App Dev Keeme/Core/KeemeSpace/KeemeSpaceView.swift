import SwiftUI

struct KeemeSpaceView: View {
    @State var songTabOpened = false
    @State private var achievementsTabOpened = false
    @State private var isQuit: Bool = false
    @State private var navigateToHome: Bool = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var isMuted = false
    @State private var isVideoOn = true
    @State private var pranayOffset = CGSize.zero // Track the offset of Pranay image
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                // Video view
                VideoView()
                    .overlay(
                        VStack {
                            Image("pranay")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .shadow(color: Color.black.opacity(1), radius: 5, x: 0, y: 0) // Adding shadow
                                .clipShape(Rectangle())
                                .offset(pranayOffset) // Apply offset
                                .gesture(DragGesture() // Drag gesture for moving the image
                                    .onChanged { gesture in
                                        self.pranayOffset = gesture.translation
                                    }
                                    .onEnded { _ in
                                        self.pranayOffset = .zero // Reset offset when dragging ends
                                    }
                                )
                        },
                        alignment: .bottomTrailing
                    )
                    .overlay(
                        VStack {
                            Text("\(formatTime(elapsedTime))")
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.lightBlack)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                            .padding(.trailing, 20)
                            .padding(.leading, 20),
                        alignment: .top
                    )
                
                // User controls
                ZStack{
                    HStack {
                        Spacer()
                        ControlButton(systemName: isMuted ? "mic.slash.fill" : "mic.fill") {
                            // Toggle mute state
                            isMuted.toggle()
                        }
                        Spacer()
                        ControlButton(systemName: isVideoOn ? "video.fill" : "video.slash.fill") {
                            // Toggle video state
                            isVideoOn.toggle()
                        }
                        Spacer()
                        if !songTabOpened{
                            Button(action: {
                                self.songTabOpened.toggle()
                            }) {
                                Image(systemName: "music.note")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .padding(15)
                                    .foregroundColor(.white)
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                        Spacer()
                        if !achievementsTabOpened {
                            ControlButton(systemName: "trophy.fill") {
                                // Achievements button action
                                self.achievementsTabOpened.toggle()
                            }
                        }
                        Spacer()
                        Button(action: {
                            // Phone down button action
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let window = windowScene.windows.first {
                                window.rootViewController = UIHostingController(rootView: MainTabView())
                                window.makeKeyAndVisible()
                                }
                        }) {
                            Image(systemName: "phone.down.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .padding(15)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(Color.lightBlack)
                    .padding(.horizontal,0)
                }
                .onReceive(timer) { _ in
                    self.elapsedTime += 1
                }
            }
            SongMenu(width: UIScreen.main.bounds.width/1.33,
                     songTabOpened:songTabOpened,
                     toggleMenu: toggleMenu)
            AchievementsMenu(width: UIScreen.main.bounds.width / 1.33, achievementsTabOpened: $achievementsTabOpened)

        }
    }
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    func toggleMenu(){
        songTabOpened.toggle()
    }
    func deviceIsiPad() -> Bool {
            return UIDevice.current.userInterfaceIdiom == .pad
        }
}

struct ControlButton: View {
    var systemName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .padding()
                .foregroundColor(.white)
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
        }
    }
}

struct VideoView: View {
    var body: some View {
        GeometryReader { geometry in
            Image("ram")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
}

extension Color {
    static let lightBlack = Color.black.opacity(0.7) // Define a light black color
}

struct KeemeSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        KeemeSpaceView()
    }
}

/*Music Palyer Code*/

struct SearchLayout: View {
    @State var search = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @Binding var selectedSongIndex: Int // Add binding for selected song index
    
    var filteredSongs: [Int] {
        if search.isEmpty {
            // If search is empty, return all songs
            return Array(1...6)
        } else {
            // Filter songs based on search query
            return (1...6).filter { index in
                let songName = "Song \(index)"
                return songName.localizedCaseInsensitiveContains(search)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                HStack {
                    Toggle(isOn: .constant(true)) {
                        Text("Choose Your Wave")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    TextField("Search", text: $search)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white.opacity(0.06))
                .cornerRadius(15)
                
                // Grid view of the songs
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredSongs, id: \.self) { index in
                        VStack {
                            Image("song image \(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(15)
                            
                            Text("Song \(index)") // Text to display below the image
                                .foregroundColor(.white) // Adjust text color as needed
                                .padding(.top, 8) // Add some top padding between image and text
                        }
                        .onTapGesture {
                            selectedSongIndex = index // Update selected song index
                        }
                        .padding(10)
                    }
                }
            }
            .padding()
        }
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct Miniplayer: View {
    var animation: Namespace.ID
    @Binding var expand: Bool
    @Binding var selectedSongIndex: Int // Add binding for selected song index
    var height = UIScreen.main.bounds.height / 4
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    @State var volume: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var isPlaying: Bool = false
    @State var currentTime: Double = 0
    @State var totalTime: Double = 180 // Total duration of the song in seconds (example value)
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
            
            HStack(spacing: 10) {
                if expand { Spacer(minLength: 0) }
                Image("song image \(selectedSongIndex)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? height : 55, height: expand ? height : 55)
                    .cornerRadius(15)
                    .padding(.all)
                
                if !expand {
                    Text("Song \(selectedSongIndex)")
                        .dynamicTypeSize(size: .headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                Spacer(minLength: 0)
                if !expand {
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .dynamicTypeSize(.xxLarge)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }
                
            }
            VStack(spacing: 0) {
                HStack {
                    if expand {
                        Text("\(timeString(from: currentTime)) / \(timeString(from: totalTime))")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                    Spacer(minLength: 0)
                    Button(action: {}) {
                        Image(systemName: "ellipsis.circle")
                            .dynamicTypeSize(.large)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                HStack{
                    Button(action: {}) {
                        Image(systemName: "backward.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    Button(action: {isPlaying.toggle()}) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                
                HStack(spacing: 15) {
                    Image(systemName: "speaker.fill")
                        .background(Color.white)
                    Slider(value: $volume)
                    Image(systemName: "speaker.wave.2.fill")
                        .background(Color.white)

                }
                .padding()
                Spacer(minLength: 0)
            }
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxHeight: expand ? .infinity : UIScreen.main.bounds.height / 15)
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -0.03)
        .offset(y: offset)
        .padding(5)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
        .ignoresSafeArea()
    }
    
    func onchanged(value: DragGesture.Value) {
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)) {
            if value.translation.height > height {
                expand = false
            }
            offset = 0
        }
    }
    
    // Function to convert time in seconds to formatted string (mm:ss)
    func timeString(from time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct songTabContent: View {
    @State var expand = false
    @Namespace var animation
    @State var selectedSongIndex: Int = 1 // Track selected song index
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 33/128, green: 33/128, blue: 33/128, alpha: 1))
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .fill(Color(UIColor(red: 33/128, green: 33/128, blue: 33/128, alpha: 1)))
                    .frame(height: UIScreen.main.bounds.height / 15)
                    .overlay(HStack {
//                        Image(systemName: "xmark").foregroundColor(.white).fontWeight(.bold)
                        Spacer()
                        Text("Music Player").foregroundColor(.white).dynamicTypeSize(.xxLarge).fontWeight(.bold)
                        Spacer()
                    }.padding())
                
                Spacer()
                SearchLayout(selectedSongIndex: $selectedSongIndex) // Pass selected song index
                Spacer()
                
            }
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                Miniplayer(animation: animation, expand: $expand, selectedSongIndex: $selectedSongIndex) // Pass selected song index
                    .background(VStack {
                        BlurView()
                    }.onTapGesture(perform: {
                        withAnimation(.spring()) {
                            expand = true
                        }
                    }))
                
            }
        }
    }
}

struct SongMenu: View {
    let width: CGFloat
    let songTabOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }.background(Color.gray.opacity(0.5))
                .opacity(self.songTabOpened ? 1 : 0)
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                    self.toggleMenu()
                }
            HStack {
                Spacer()
                songTabContent().frame(width: width)
                    .offset(x: songTabOpened ? 0 : width)
                    .animation(.default)
                
            }
            
        }
    }
}

struct SongInterface: View {
    @State var songTabOpened = false
    
    var body: some View {
        ZStack {
            if !songTabOpened {
                Button(action: {
                    self.songTabOpened.toggle()
                }, label: {
                    Text("Open music").frame(width: 200, height: 50, alignment: .center).foregroundColor(.blue)
                })
            }
            SongMenu(width: UIScreen.main.bounds.width / 1.33,
                     songTabOpened: songTabOpened,
                     toggleMenu: toggleMenu)
        }
        .edgesIgnoringSafeArea(.trailing)
        
    }
    
    func toggleMenu() {
        songTabOpened.toggle()
    }
}

extension Text {
    func dynamicTypeSize(size: Font.TextStyle) -> Text {
        switch size {
        case .largeTitle:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize, weight: .bold))
        case .title:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold))
        case .headline:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .bold))
        case .subheadline:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .bold))
        case .body:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .bold))
        case .callout:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .callout).pointSize, weight: .bold))
        case .footnote:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .footnote).pointSize, weight: .bold))
        case .caption:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .caption1).pointSize, weight: .bold))
        case .caption2:
            return self.font(.system(size: UIFont.preferredFont(forTextStyle: .caption2).pointSize, weight: .bold))
        @unknown default:
            return self
        }
    }
}



/*Achievements Code*/

struct GifView: UIViewRepresentable {
    let gifName: String
    @Binding var isAnimating: Bool

    class Coordinator: NSObject {
        var parent: GifView

        init(parent: GifView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        if isAnimating {
            if let gifPath = Bundle.main.path(forResource: gifName, ofType: "gif"),
               let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)),
               let source = CGImageSourceCreateWithData(gifData as CFData, nil) {

                let images: [UIImage] = (0..<CGImageSourceGetCount(source)).compactMap {
                    if let cgImage = CGImageSourceCreateImageAtIndex(source, $0, nil) {
                        return UIImage(cgImage: cgImage)
                    }
                    return nil
                }

                uiView.animationImages = images

                if let gifDuration = getGifDuration(source: source) {
                    uiView.animationDuration = TimeInterval(gifDuration)
                }

                uiView.startAnimating()
            }
        } else {
            uiView.stopAnimating()
            uiView.image = nil
        }
    }

    private func getGifDuration(source: CGImageSource) -> Double? {
        guard let gifInfo = CGImageSourceCopyProperties(source, nil) as? [String: Any],
              let gifProperties = gifInfo[kCGImagePropertyGIFDictionary as String] as? [String: Any],
              let duration = gifProperties[kCGImagePropertyGIFDelayTime as String] as? Double
        else {
            return nil
        }
        return duration
    }
}

struct Achievement: View {
    @State private var achievementsTabOpened = false

    var body: some View {
        ZStack {
            if !achievementsTabOpened {
                Button(action: {
                    self.achievementsTabOpened.toggle()
                }) {
                    Image(systemName: "trophy")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.blue)
                }
            }
            AchievementsMenu(width: UIScreen.main.bounds.width / 1.33, achievementsTabOpened: $achievementsTabOpened)
        }
        .edgesIgnoringSafeArea(.trailing)
    }
}

struct AchievementsMenu: View {
    let width: CGFloat
    @Binding var achievementsTabOpened: Bool

    var body: some View {
        ZStack {
            // Background overlay
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(achievementsTabOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                // Close menu when tapped outside
                self.achievementsTabOpened.toggle()
            }

            HStack {
                Spacer()
                AchievementsTabContent(achievementsTabOpened: $achievementsTabOpened)
                    .frame(width: width)
                    .offset(x: achievementsTabOpened ? 0 : width)
                    .animation(.default)
            }
        }
    }
}

struct AchievementsTabContent: View {
    @Binding var achievementsTabOpened: Bool
    @State private var expand = false
    @Namespace private var animation
    @State private var isAnimating = false
    @State private var isCelebrationEnabled = false
    @State private var yourAchievements: [String] = [ ]
    @State private var newAchievementText: String = ""
    
    var body: some View {
            ZStack {
                Color(UIColor(red: 33/128, green: 33/128, blue: 33/128, alpha: 1))
                
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .fill(Color(UIColor(red: 33/128, green: 33/128, blue: 33/128, alpha: 1)))
                        .frame(height: UIScreen.main.bounds.height / 15)
                        .overlay(
                            HStack {
                                Spacer()
                                Text("Achievements")
                                    .foregroundColor(.white)
                                    .dynamicTypeSize(.xxLarge)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                                .padding())
                    
                    ScrollView {
                    HStack {
                        Text("Your Achievements")
                            .underline()
                            .foregroundColor(.white)
                            .dynamicTypeSize(.xLarge)
                            .fontWeight(.bold)
                            .padding(.leading, 70)
                            .padding(.top, 10)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(yourAchievements, id: \.self) { achievement in
                            CheckBoxView(isChecked: $isCelebrationEnabled, text: achievement)
                        }
                        
                        HStack {
                            TextField("Add Achievement", text: $newAchievementText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 20)
                            
                            Button(action: {
                                if !newAchievementText.isEmpty {
                                    yourAchievements.append(newAchievementText)
                                    newAchievementText = ""
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 20)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.leading, 50)
                    .padding(.top, 30)
                    
                    
                    Button(action: {
                        guard isCelebrationEnabled else { return }
                        
                        withAnimation {
                            isAnimating.toggle()
                        }
                        
                        // Schedule a task to stop the animation after 5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                isAnimating = false
                            }
                        }
                    })  {
                        Text("Let's Celebrate")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.top, 40)
                            .padding(.leading, 10)
                    }
                    .overlay(
                        isAnimating ? GifView(gifName: "cc", isAnimating: $isAnimating)
                            .frame(width: 400, height: 400) // Adjust the frame size as needed
                        : nil
                    )
                    .disabled(!isCelebrationEnabled)
                    
                        
                            HStack {
                                Text("Rita's Achievements")
                                    .underline()
                                    .foregroundColor(.white)
                                    .dynamicTypeSize(.xLarge)
                                    .fontWeight(.bold)
                                    .padding(.leading)
                                    .padding(.top, 10)
                            }
                            .padding(.top, 30)
                            
                            VStack(alignment: .leading, spacing: 20) {
                                CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 1")
                                CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 2")
                                CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 3")
                                CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 4")
                                // Add more achievements as needed
                            }
                            .padding(.leading,-10)
                            .padding(.top, 30)
                        
                    Spacer()
                }
                
                VStack(alignment: .trailing, spacing: 0) {
                    Spacer()
                        .background(
                            VStack {
                                // Your additional content here
                            }
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        expand = true
                                    }
                                }
                        )
                }
            }
        }
    }
}

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .onTapGesture {
                    isChecked.toggle()
                }
            
            Text(text)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
    }
}



