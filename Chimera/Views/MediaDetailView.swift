//
//  MediaDetailView.swift
//  Chimera
//
//  Created by Nicola Rigoni on 12/01/23.
//

import SwiftUI
import AVKit

struct MediaModel: Identifiable {
    let id: String = UUID().uuidString
    let fileName: String
    let isVideo: Bool
    
    init(fileName: String, isVideo: Bool = false) {
        self.fileName = fileName
        self.isVideo = isVideo
    }
}


struct MediaDetailView: View {
    
    let medias: [MediaModel] = [
        MediaModel(fileName: "concert1"),
        MediaModel(fileName: "concert2"),
        MediaModel(fileName: "Tamburellare - 5026", isVideo: true),
        MediaModel(fileName: "concert3"),
        MediaModel(fileName: "Violoncello - 33565", isVideo: true)
    ]
    
    enum ScrubbingState {
        case none
        case scrubbingStart
        case scrubbingEnd
    }
    
    @State private var selectedItem: String = ""
    @State private var player: AVPlayer = AVPlayer()
    @State private var isPlaying: Bool = false
    @State private var offsetXThumbnail: CGSize = .zero
    @State private var currentTime: Double = 0.0
    @State private var scrubbingState: ScrubbingState = .none
    @State private var showPreview: Bool = false
    @State private var showingOptions = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                ZStack(alignment: .bottom) {
                    TabView(selection: $selectedItem) {
                        ForEach(medias) { item in
                            if !item.isVideo {
                                ZStack {
                                    Color.black
                                    Image(item.fileName)
                                        .resizable()
                                        .scaledToFit()
                                        .tag(item.id)
                                }
                                
                            } else {
                                ZStack(alignment: .top) {
                                    VideoPlayer(player: player)
                                        .tag(item.id)
                                    HStack {
                                        if let currentItem = player.currentItem {
                                            Text("\(currentTime, specifier: "%.2f")")
                                                .font(.headline)
                                            Slider(value: $currentTime, in: 0...player.currentItem!.asset.duration.seconds) { scrubStarted in
                                                if scrubStarted {
                                                    scrubbingState = .scrubbingStart
                                                } else {
                                                    scrubbingState = .scrubbingEnd
                                                }
                                                print("scrubStarted \(scrubStarted.description)")
                                                print("seek to: \(currentTime)")
                                            }
                                            
                                            
                                            Text("\(player.currentItem!.asset.duration.seconds, specifier: "%.2f")")
                                                .font(.headline)
                                        }
                                    }
                                    .padding()
                                    .background(Material.ultraThin)
                                }
                                
                            }
                            
                        }
                    }
                    if showPreview {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(medias) { item in
                                    if !item.isVideo {
                                        Image(item.fileName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: selectedItem == item.id ? 100 : 50, height: 50)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .animation(.easeInOut, value: selectedItem)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(selectedItem == item.id ? .white : .clear, lineWidth: 4)
                                            }
                                            .onTapGesture {
                                                selectedItem = item.id
                                            }
                                            
                                    } else {
                                        //                                    Rectangle()
                                        //                                        .foregroundColor(.white)
                                        //                                        .frame(width: 100, height: 50)
                                        let media = checkIsVideo(selectedMedia: item.id)
                                        Image(uiImage: generateThumbnail(url: Bundle.main.url(forResource: medias[media.index!].fileName, withExtension: "mp4")!)!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: selectedItem == item.id ? 100 : 50, height: 50)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(selectedItem == item.id ? .white : .clear, lineWidth: 4)
                                            }
                                            .onTapGesture {
                                                selectedItem = item.id
                                            }
                                    }
                                }
                            }
                            .padding()
                        }
                        
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showPreview.toggle()
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .navigationTitle("Title")
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: selectedItem, perform: { newValue in
                    isPlaying = false
                    player.pause()
                    player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 600))
                    currentTime = 0.0
                    let media = checkIsVideo(selectedMedia: newValue)
                    if media.isVideo {
                        player = AVPlayer(url: Bundle.main.url(forResource: medias[media.index!].fileName, withExtension: "mp4")!)
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            isPlaying ? player.pause() : player.play()
                            isPlaying.toggle()
                            if isPlaying {
                                
                                player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.2, preferredTimescale: 600), queue: .main) { time in
                                    print("change")
                                    if scrubbingState == .none {
                                        currentTime = time.seconds
                                    } else if scrubbingState == .scrubbingEnd {
                                        player.seek(to: CMTime(seconds: currentTime, preferredTimescale: 600))
                                        scrubbingState = .none
                                    }
                                    
                                    if currentTime == player.currentItem!.asset.duration.seconds {
                                        isPlaying = false
                                        player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 600))
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        }
                        .opacity(checkIsVideo(selectedMedia: selectedItem).isVideo ? 1.0 : 0.0)
                        
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            showingOptions.toggle()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .confirmationDialog("Are you sure to delete?", isPresented: $showingOptions, titleVisibility: .visible) {
                            Button("Delete", role: .destructive) {
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func checkIsVideo(selectedMedia: String) -> (isVideo: Bool, index: Int? ) {
        if let index = medias.firstIndex(where: { $0.id == selectedMedia }) {
            if medias[index].isVideo {
                return (true, index)
            }
        }
        return (false, nil)
    }
    
    func generateThumbnail(url: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            // Swift 5.3
            let cgImage = try imageGenerator.copyCGImage(at: .zero,
                                                         actualTime: nil)
            
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
}

struct MediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MediaDetailView()
        }
        
    }
}
