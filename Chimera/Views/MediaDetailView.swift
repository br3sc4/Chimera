//
//  MediaDetailView.swift
//  Chimera
//
//  Created by Nicola Rigoni on 12/01/23.
//

import SwiftUI
import AVKit

struct MediaDetailView: View {
    let media: [MediaType]
    
    private enum ScrubbingState {
        case none
        case scrubbingStart
        case scrubbingEnd
    }
    
    @Binding var selectedItem: String
    @State private var player: AVPlayer = AVPlayer()
    @State private var isPlaying: Bool = false
    @State private var offsetXThumbnail: CGSize = .zero
    @State private var currentTime: Double = 0.0
    @State private var scrubbingState: ScrubbingState = .none
    @State private var showPreview: Bool = false
    @State private var showingOptions = false
    
    var body: some View {
        ZStack {
            Color.black
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedItem) {
                    ForEach(media) { item in
                        if case let .image(name) = item {
                            ZStack {
                                Color.black
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .tag(item.id)
                            }
                            
                        } else {
                            ZStack(alignment: .top) {
                                VideoPlayer(player: player)
                                    .tag(item.id)
                                    if player.currentItem != nil {
                                        HStack {
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
                                        
                                        Text(player.currentItem!.asset.duration.seconds.formatted(.number.precision(.fractionLength(2))))
                                            .font(.headline)
                                        }
                                        .padding()
                                        .background(Material.ultraThin)
                                    }
                            }
                        }
                    }
                }
                
                if showPreview {
                    MediaDetailPreview(selectedItem: $selectedItem, media: media)
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
            .onChange(of: selectedItem) { newId in
                loadVideo(withId: newId)
            }
            .onAppear {
                loadVideo(withId: selectedItem)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        isPlaying ? player.pause() : player.play()
                        isPlaying.toggle()
                        if isPlaying {
                            player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.2, preferredTimescale: 600), queue: .main) { time in
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
                    .opacity(checkIsVideo(selectedMedia: selectedItem) ? 1.0 : 0.0)
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
    
    private func loadVideo(withId id: String) {
        isPlaying = false
        player.pause()
        player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 600))
        currentTime = 0.0
        
        guard let foundItem = media.first(where: { $0.id == id }), case let .video(video) = foundItem else { return }
        player = AVPlayer(url: video.url)
    }
    
    private func checkIsVideo(selectedMedia: String?) -> Bool {
        if let selectedMedia, let foundItem = media.first(where: { $0.id == selectedMedia }), case .video(_) = foundItem {
            return true
        }
        return false
    }
}

struct MediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MediaDetailView(media: [
                .image(name: "concert1"),
                .image(name: "concert2"),
                .video(videoMemo: VideoMemo(name: "Tamburellare - 5026", ext: "mp4")),
                .image(name: "concert3"),
                .video(videoMemo: VideoMemo(name: "Violoncello - 33565", ext: "mp4"))
            ], selectedItem: .constant(""))
        }
        
    }
}
