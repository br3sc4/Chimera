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
    
    @State private var selectedItem: String = ""
    @State private var player: AVPlayer = AVPlayer()
    @State private var isPlaying: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                VStack {
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
                                VideoPlayer(player: player)
                                    .tag(item.id)
                            }
                                
                        }
                    }
//                    ScrollView(.horizontal, showsIndicators: false) {
//                       Rectangle()
//                            .foregroundColor(.white)
//                            .frame(width: 50, height: 20)
//                            
//                    }
//                    .padding()
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .navigationTitle("Title")
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: selectedItem, perform: { newValue in
                    isPlaying = false
                    player.pause()
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
                        } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        }
                        .opacity(checkIsVideo(selectedMedia: selectedItem).isVideo ? 1.0 : 0.0)
                        
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(role: .destructive) {
                            
                        } label: {
                            Image(systemName: "trash")
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
}

struct MediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MediaDetailView()
        }
        
    }
}
