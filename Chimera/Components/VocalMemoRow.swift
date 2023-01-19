//
//  VocalMemoRow.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct VocalMemoRow: View {
    
    let vocalMemo: VocalMemo
    let sampleAudioUrl = Bundle.main.url(forResource: "01-11-22_at_18_30_44", withExtension: "m4a")

    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
       
        
            HStack{
            Image(systemName: "speaker.wave.3.fill")
                .foregroundColor(.accentColor)
            Text(vocalMemo.title)
                    .foregroundColor(.primary)
                Spacer()
                
                
                if !audioPlayer.isPlaying{
                    Button(action: {
                        self.audioPlayer.startPlayback(audio: sampleAudioUrl!)
                    }, label: {
                        Image(systemName: "play.fill" )
                            .foregroundColor(.accentColor)
                    })
                } else{
                    Button(action: {
                        self.audioPlayer.stopPlayback()
                    }, label: {
                        Image(systemName: "pause.fill" )
                            .foregroundColor(.accentColor)
                    })
                }
        }.padding(.horizontal)
    }
}

struct VocalMemoRow_Previews: PreviewProvider {
    static var previews: some View {
        VocalMemoRow(vocalMemo: VocalMemo(title: "test", urlString: ""))
    }
}
