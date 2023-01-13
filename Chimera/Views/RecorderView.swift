//
//  RecorderView.swift
//  Chimera
//
//  Created by Simon Bestler on 11.01.23.
//

import SwiftUI

struct RecorderView: View {
    
    @ObservedObject var recoderVM = RecorderViewModel()
    
    var body: some View {
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

struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView()
    }
}
