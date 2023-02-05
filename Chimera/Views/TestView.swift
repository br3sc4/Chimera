//
//  TestView.swift
//  Chimera
//
//  Created by Nicola Rigoni on 04/02/23.
//

import SwiftUI
import AVKit

class MediaDetailVM: ObservableObject {
    
    enum ScrubbingState {
        case none
        case scrubbingStart
        case scrubbingEnd
    }
    @Published var media: [MediaMemo]
    @Published var player: AVPlayer = AVPlayer()
    @Published var isPlaying: Bool = false
    @Published var scrubbingState: ScrubbingState = .none
    @Published var currentTime: Double = 0.0
    
    init(mediaMemo: [MediaMemo]) {
        media = mediaMemo
    }
    
    func loadVideo(withId id: UUID) {
        isPlaying = false
        player.pause()
        player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 600))
        currentTime = 0.0
        
        guard let foundItem = media.first(where: { $0.id == id }), foundItem.isVideo else { return }
        player = AVPlayer(url: foundItem.url)
    }
    
    func checkIsVideo(selectedMedia: UUID?) -> Bool {
        if let selectedMedia, let foundItem = media.first(where: { $0.id == selectedMedia }), foundItem.isVideo {
            return true
        }
        return false
    }
}

struct TestView: View {
    @StateObject private var vm: MediaDetailVM
    @Binding var selectedItem: UUID
    
    @State private var offsetXThumbnail: CGSize = .zero
    @State private var showPreview: Bool = false
    @State private var showingOptions = false
    
    init(selectedItem: Binding<UUID>, memo: [MediaMemo]) {
        self._selectedItem = selectedItem
        _vm = StateObject(wrappedValue: MediaDetailVM(mediaMemo: memo))
    }
    
    var body: some View {
        ZStack {
            Color.black
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedItem) {
                    ForEach(vm.media) { item in
                        if !item.isVideo {
                            ZStack {
                                Color.black
                                AsyncImage(url: item.url) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .tag(item.id)
                                } placeholder: {
                                    EmptyView()
                                }
                            }
                        } else {
                            ZStack(alignment: .top) {
                                VideoPlayer(player: vm.player)
                                    .tag(item.id)
                                if vm.player.currentItem != nil {
                                    HStack {
                                        Text("\(vm.currentTime, specifier: "%.2f")")
                                            .font(.headline)
                                        Slider(value: $vm.currentTime, in: 0...vm.player.currentItem!.asset.duration.seconds) { scrubStarted in
                                            if scrubStarted {
                                                vm.scrubbingState = .scrubbingStart
                                            } else {
                                                vm.scrubbingState = .scrubbingEnd
                                            }
                                            print("scrubStarted \(scrubStarted.description)")
                                            print("seek to: \(vm.currentTime)")
                                        }
                                        
                                        Text(vm.player.currentItem!.asset.duration.seconds.formatted(.number.precision(.fractionLength(2))))
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
                    MediaDetailPreview(selectedItem: $selectedItem, media: vm.media)
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
                vm.loadVideo(withId: newId)
            }
            .onAppear {
                vm.loadVideo(withId: selectedItem)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        vm.isPlaying ? vm.player.pause() : vm.player.play()
                        vm.isPlaying.toggle()
                        if vm.isPlaying {
                            vm.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.2, preferredTimescale: 600), queue: .main) { time in
                                if vm.scrubbingState == .none {
                                    vm.currentTime = time.seconds
                                } else if vm.scrubbingState == .scrubbingEnd {
                                    vm.player.seek(to: CMTime(seconds: vm.currentTime, preferredTimescale: 600))
                                    vm.scrubbingState = .none
                                }
                                
                                if vm.currentTime == vm.player.currentItem!.asset.duration.seconds {
                                    vm.isPlaying = false
                                    vm.player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 600))
                                }
                            }
                        }
                    } label: {
                        Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
                    }
                    .opacity(vm.checkIsVideo(selectedMedia: selectedItem) ? 1.0 : 0.0)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingOptions.toggle()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .confirmationDialog("Are you sure to delete?",
                                        isPresented: $showingOptions,
                                        titleVisibility: .visible) {
                        Button("Delete", role: .destructive) {
                            
                        }
                    }
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(selectedItem: .constant(UUID()), memo: [])
    }
}
