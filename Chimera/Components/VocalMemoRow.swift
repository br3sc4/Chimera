//
//  VocalMemoRow.swift
//  Chimera
//
//  Created by Antonella Giugliano on 12/01/23.
//

import SwiftUI

struct VocalMemoRow: View {
    let vocalMemo: VocalMemo
    @State var isPlaying = false
    var body: some View {
       
            HStack{
            Image(systemName: "speaker.wave.3.fill")
                .foregroundColor(.accentColor)
            Text(vocalMemo.title)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    isPlaying.toggle()
                },
                       label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill" )
                        .foregroundColor(.accentColor)
                })
        }.padding(.horizontal)
    }
}

struct VocalMemoRow_Previews: PreviewProvider {
    static var previews: some View {
        VocalMemoRow(vocalMemo: events[0].VocalMemos![0])
    }
}
