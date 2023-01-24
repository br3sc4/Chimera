//
//  RecorderView.swift
//  Chimera
//
//  Created by Simon Bestler on 11.01.23.
//

import SwiftUI

struct RecorderView: View {
    
    @ObservedObject var recoderVM = RecorderViewModel()
    let sampleAudioUrl = Bundle.main.url(forResource: "01-11-22_at_18_30_44", withExtension: "m4a")
    
    var body: some View {
        VStack{
            
                //recorded stuff
                VocalMemoRow(vocalMemo: VocalMemo(title: "test", urlString: sampleAudioUrl!.absoluteString))
            Spacer()
            HStack{
                if recoderVM.isRecording {
                    Button(action: recoderVM.stopRecording, label: {
                        Image(systemName: "stop.circle")
                            .font(.system(size: 64))
                    })
                } else {
                    Button(action: recoderVM.startRecording, label: {
                        Image(systemName: "mic.circle")
                            .font(.system(size: 64))
                    })
                }
            }
        }
    }
}

struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView()
    }
}
