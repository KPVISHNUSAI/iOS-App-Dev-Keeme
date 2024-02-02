import SwiftUI
import UIKit

struct KeemeSpaceView: View {
    @State private var isMicOn: Bool = true
    @State private var isCameraFlipped: Bool = false
    @State private var isSpeakerOn: Bool = true
    @State private var isCameraOn: Bool = true
    @State private var isQuit: Bool = false
    @State private var navigateToHome: Bool = false
    @State var songTabOpened = false
    @GestureState private var dragOffset: CGSize = .zero
    @State private var achievementsTabOpened = false
    
    var body: some View {
        
            ZStack {
                Color.white
                
                VStack {
                    Spacer()
                    // Video calling face time space
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.gray.opacity(0.7))
                        .padding()
                        .overlay(
                            VStack {
                                ProgressView(value: 0.7)
                                    .shadow(radius: 10)
                                    .padding(.trailing, 10)
                            }
                            .padding(.trailing, 20)
                            .padding(.leading, 20),
                            alignment: .top
                        )
                        .overlay(
                            VStack {
                                Image("Rita 2")
                                Text("Rita")
                            },
                            alignment: .center
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.9))
                                .frame(width: 150, height: 150)
                                .padding(.trailing, 30)
                                .padding(.bottom, 30)
                                .overlay(
                                    VStack {
                                        Image("Lauren 2")
                                        Text("You")
                                    },
                                    alignment: .center
                                )
                            ,
                            alignment: .bottomTrailing
                        )
                    
                    ZStack {
                        Color.gray.opacity(0.5)
                            .frame(minWidth: 400, maxWidth: .infinity, minHeight: 60, maxHeight: 100)
                            .offset(y: dragOffset.height)
                            .gesture(
                                DragGesture()
                                    .updating($dragOffset) { value, state, _ in
                                        state = value.translation
                                    }
                                    .onEnded { value in
                                        // Add logic if needed when drag ends
                                    }
                            )
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: deviceIsiPad() ? 70 : 20) {
                                Spacer()
                                VideoControlButton(systemName: isMicOn ? "mic.fill" : "mic.slash.fill") {
                                    isMicOn.toggle()
                                }
                                
                                VideoControlButton(systemName: isCameraFlipped ? "arrow.triangle.2.circlepath.camera.fill" : "camera.fill") {
                                    isCameraFlipped.toggle()
                                }
                                
                                VideoControlButton(systemName: isSpeakerOn ? "speaker.3.fill" : "speaker.slash.fill") {
                                    isSpeakerOn.toggle()
                                }
                                
                                VideoControlButton(systemName: isCameraOn ? "video.fill" : "video.slash.fill") {
                                    isCameraOn.toggle()
                                }
                                
                                if !songTabOpened{
                                    Button(action: {
                                        self.songTabOpened.toggle()
                                    }) {
                                        Image(systemName: "music.note")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(
                                                width: deviceIsiPad() ? 30 : 20,
                                                height: deviceIsiPad() ? 30 : 20
                                            )
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(.gray)
                                            .clipShape(Circle())
                                    }
                                }
                                
                                if !achievementsTabOpened {
                                    Button(action: {
                                        self.achievementsTabOpened.toggle()
                                    }) {
                                        Image(systemName: "trophy")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(
                                                width: deviceIsiPad() ? 30 : 20,
                                                height: deviceIsiPad() ? 30 : 20
                                            )
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(.gray)
                                            .clipShape(Circle())
                                                                          }
                                }
                                
                            
                                Button(action: {
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let window = windowScene.windows.first {
                                            window.rootViewController = UIHostingController(rootView: MainTabView())
                                            window.makeKeyAndVisible()
                                        }
                                                }) {
                                                    Image(systemName: "xmark")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(minWidth: 20, maxWidth: 30, minHeight: 20, maxHeight: 30)
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .background(Color.red)
                                                        .clipShape(Circle())
                                                }
                                
                                Spacer()
                                
                            }
                            .padding()
                            
                        }
                        .offset(y: dragOffset.height)
                    }
                }
                //Song Page slider
                SongMenu(width: UIScreen.main.bounds.width/1.33,
                         songTabOpened:songTabOpened,
                         toggleMenu: toggleMenu)
                
                //Achievemets Page Slider
                AchievementsMenu(width: UIScreen.main.bounds.width / 1.33, achievementsTabOpened: $achievementsTabOpened)

            }
    }
    func deviceIsiPad() -> Bool {
            return UIDevice.current.userInterfaceIdiom == .pad
        }
    func toggleMenu(){
        songTabOpened.toggle()
    }
}

struct VideoControlButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: systemName)
                .aspectRatio(contentMode: .fit)
//                .frame(minWidth: 20, maxWidth: 30, minHeight: 20, maxHeight: 30)
                .frame(
                    width: deviceIsiPad() ? 30 : 20,
                    height: deviceIsiPad() ? 30 : 20
                )
                .foregroundColor(.white)
                .padding()
                .background(.gray)
                .clipShape(Circle())
        })
    }
    func deviceIsiPad() -> Bool {
            return UIDevice.current.userInterfaceIdiom == .pad
    }
}

struct KeemeSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        KeemeSpaceView()
        
    }
}



//Music code
//
//  SongInterface.swift
//  KeemeV2
//
//  Created by user2 on 26/01/24.
//


struct SearchLayout:View {
    @State var search = ""
    var columns = Array(repeating: GridItem(.flexible(),spacing:20), count:2)
    var body: some View {
        ScrollView{
            VStack(spacing:18){
//                HStack{
//                    Text("Search")
//                        .dynamicTypeSize(.xxLarge)
//                        .fontWeight(.heavy)
//                        .foregroundColor(.primary)
//                    Spacer(minLength: 0)
//
//                }
                HStack{
                    Toggle(isOn: .constant(true)) {
                        Text("chosse ur wave")
                    }
                }
                HStack(spacing:15){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    Text("Search")
                        .foregroundColor(.white)
                    TextField("Search", text: $search)
                    
                    
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.white.opacity(0.06))
                .cornerRadius(15)
                
                //Grid view of the songs
                LazyVGrid(columns: columns, spacing:20){
                    ForEach(1...10, id: \.self){
                        index in
                        Image("song image \(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            //.frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 180)
                            .cornerRadius(15)
                            //.padding(10)
                            
                            
                    }
                    
                }
            }
            .padding()
        }
    }
}
                        
                        
                        
     //blured background code
struct BlurView:UIViewRepresentable{
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView (effect: UIBlurEffect(style: .systemThinMaterialDark))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct Miniplayer:View {
    var animation: Namespace.ID
    @Binding var expand : Bool
    var height = UIScreen.main.bounds.height/4
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets

    @State var volume : CGFloat = 0
    
    @State var offset : CGFloat = 0
    var body: some View {
        VStack{
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
               
               // .padding(.top, expand ? safeArea?.top:0)
               //.padding(.vertical, expand ? 30 : 0)
            
           
            HStack(spacing:10){
                
                if expand{Spacer(minLength: 0)}
                Image("song image 1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? height:  55, height: expand ? height: 55)
                    .cornerRadius(15)
                    .padding(.all)
                
                if !expand{
                    Text("Paradise")
                        .dynamicTypeSize(.xLarge)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                Spacer(minLength: 0)
                if !expand{
                    Button(action: {}, label: {
                        Image(systemName: "play.fill")
                            .dynamicTypeSize(.xLarge)
                            .foregroundColor(.white)
                    })
                    Button(action: {}, label: {
                        Image(systemName: "forward.fill")
                            .dynamicTypeSize(.xLarge)
                            .foregroundColor(.white)
                    }).padding(.trailing)}
                
            }
            VStack(spacing:0){
                HStack{
                    if expand{
                        Text("Paradise")
                            .dynamicTypeSize(.xLarge)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    Spacer(minLength: 0)
                    Button(action:{}){
                        Image(systemName: "ellipsis.circle")
                            .dynamicTypeSize(.large)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                Button(action: {}){
                    Image(systemName: "stop.fill")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }.padding()
                
                HStack(spacing:15){
                    Image(systemName: "speaker.fill")
                    Slider(value: $volume)
                    Image(systemName: "speaker.wave.2.fill")
                    
                }
                .padding()
                Spacer(minLength: 0)
//                HStack(spacing:22){
//                    Button(action: {}){
//                        Image(systemName: "arrow.up.message")
//                            .font(.largeTitle)
//                            .foregroundColor(.primary)
//                        Image(systemName: "airplayaudio")
//                            .font(.largeTitle)
//                            .foregroundColor(.primary)
//                        Image(systemName: "list.bulllet")
//                            .font(.largeTitle)
//                            .foregroundColor(.primary)
//                    }
//                }
                //.padding( .bottom, safeArea ? .bottom == 0 ? 15 : safeArea ? .bottom)
            }
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxHeight: expand ? .infinity: UIScreen.main.bounds.height/15)
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0: -0.03)
        .offset(y: offset)
        .padding(5)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
        .ignoresSafeArea()
        
        
    }
    func onchanged(value: DragGesture.Value){
        if value.translation.height > 0 && expand{
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            if value.translation.height > height {
                expand = false
            }
            offset = 0
        }
    }
}

struct songTabContent:View {
    //the slider
   
    @State var expand = false
    @Namespace var animation
    var body: some View {
        ZStack{
            Color(UIColor(red:33/128,green: 33/128, blue: 33/128,alpha: 1))
            VStack(alignment : .leading, spacing:0){
                Rectangle()
                    .fill(Color(UIColor(red:33/128,green: 33/128, blue: 33/128,alpha: 1)))
                    .frame(height: UIScreen.main.bounds.height/15)
                    .overlay(HStack {
                        
                        Image(systemName: "xmark").foregroundColor(.white).fontWeight(.bold)
                        Spacer()
                        Text("Music Player").foregroundColor(.white).dynamicTypeSize(.xLarge).fontWeight(.bold)
                        Spacer()
                    }.padding())
                    
                
                Spacer()
               SearchLayout()
                Spacer()
                
                
                
            }
            VStack(alignment: .trailing, spacing: 0){
                Spacer()
                Miniplayer(animation: animation, expand: $expand)
                    .background(VStack {
                        BlurView()
                    }.onTapGesture(perform:{
                        withAnimation(.spring()){expand=true
                        }
                    }))
                
            }
        }
    }
}

//the slider content
struct SongMenu: View {
    //background whoes background is this man ?
    let width:CGFloat
    let songTabOpened:Bool
    let toggleMenu: ()-> Void
    var body: some View {
        ZStack{
            GeometryReader{_ in
                EmptyView()
            }.background(Color.gray.opacity(0.5))
                .opacity(self.songTabOpened ? 1 : 0)
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                    self.toggleMenu()
                }
            HStack{
                Spacer()
                songTabContent().frame(width:width)
                    .offset(x: songTabOpened ? 0: width)
                    .animation(.default)
                
            }
            
        }
    }
}


//main connection to all structs
struct SongInterface: View {
    
    @State var songTabOpened = false
    var body: some View {
        ZStack{
            if !songTabOpened{
                Button(action: {
                    self.songTabOpened.toggle()
                }, label: {
                    Text("Open music").frame(width: 200, height: 50, alignment: .center).foregroundColor(.blue)
                })
            }
            SongMenu(width: UIScreen.main.bounds.width/1.33,
                     songTabOpened:songTabOpened,
                     toggleMenu: toggleMenu)
        }
        .edgesIgnoringSafeArea(.trailing)
        
    }
    func toggleMenu(){
        songTabOpened.toggle()
    }
}

//#Preview {
//    SongInterface()
//}




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

//struct AchievementsTabContent: View {
//    @Binding var achievementsTabOpened: Bool
//    @State private var expand = false
//    @Namespace private var animation
//    @State private var isAnimating = false
//    @State private var isCelebrationEnabled = false
//
//    var body: some View {
//        ZStack {
//            Color(UIColor(red: 33/128, green: 33/128, blue: 33/128, alpha: 1))
//
//            VStack(alignment: .leading, spacing: 0) {
//                Rectangle()
//                    .fill(Color(UIColor(red: 33/128, green: 33/128, blue: 33/128, alpha: 1)))
//                    .frame(height: UIScreen.main.bounds.height / 15)
//                    .overlay(
//                        HStack {
//                            Button(action: {
//                                // Close the content when xmark is tapped
//                                self.achievementsTabOpened.toggle()
//                            }) {
//                                Image(systemName: "xmark")
//                                    .foregroundColor(.white)
//                                    .fontWeight(.bold)
//                            }
//                            Spacer()
//                            Text("Achievements")
//                                .foregroundColor(.white)
//                                .dynamicTypeSize(.xLarge)
//                                .fontWeight(.bold)
//                            Spacer()
//                        }
//                        .padding())
//
//                HStack {
//                    Text("Your Achievements")
//                        .underline()
//                        .foregroundColor(.white)
//                        .dynamicTypeSize(.xLarge)
//                        .fontWeight(.bold)
//                        .padding(.leading, 70)
//                        .padding(.top, 10)
//                    Spacer()
//                }
//
//                VStack(alignment: .center, spacing: 20) {
//                                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 1")
//                                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 2")
//                                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 3")
//                                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 4")
//                                    // Add more achievements as needed
//                                }
//                .padding(.leading, 50)
//                .padding(.top, 30)
//
//                Button(action: {
//                                    guard isCelebrationEnabled else { return }
//
//                                    withAnimation {
//                                        isAnimating.toggle()
//                                    }
//
//                                    // Schedule a task to stop the animation after 5 seconds
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                                        withAnimation {
//                                            isAnimating = false
//                                        }
//                                    }
//                                })  {
//                    Text("Let's Celebrate")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                        .padding(.top, 40)
//                        .padding(.leading, 80)
//                }
//                .overlay(
//                    isAnimating ? GifView(gifName: "cc", isAnimating: $isAnimating)
//                        .frame(width: 400, height: 400) // Adjust the frame size as needed
//                    : nil
//                )
//                .disabled(!isCelebrationEnabled)
//                
//                HStack {
//                    Text("Rita's Achievements")
//                        .underline()
//                        .foregroundColor(.white)
//                        .dynamicTypeSize(.xLarge)
//                        .fontWeight(.bold)
//                        .padding(.leading, 70)
//                        .padding(.top, 10)
//                }
//                .padding(.top, 30)
//
//                VStack(alignment: .center, spacing: 20) {
//                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 1")
//                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 2")
//                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 3")
//                    CheckBoxView(isChecked: $isCelebrationEnabled, text: "Achievement 4")
//                    // Add more achievements as needed
//                }
//                .padding(.leading, 50)
//                .padding(.top, 30)
//
//                Spacer()
//            }
//
//            VStack(alignment: .trailing, spacing: 0) {
//                Spacer()
//                    .background(
//                        VStack {
//                            // Your additional content here
//                        }
//                        .onTapGesture {
//                            withAnimation(.spring()) {
//                                expand = true
//                            }
//                        }
//                    )
//            }
//        }
//    }
//}

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
                                Button(action: {
                                    // Close the content when xmark is tapped
                                    self.achievementsTabOpened.toggle()
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                Text("Achievements")
                                    .foregroundColor(.white)
                                    .dynamicTypeSize(.xLarge)
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


//#if DEBUG
//struct Achievement_Previews: PreviewProvider {
//    static var previews: some View {
//        Achievement()
//    }
//}
//#endif
