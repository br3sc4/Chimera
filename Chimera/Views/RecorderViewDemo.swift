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
            Spacer()
            Button("Start recording", action: recoderVM.startRecording)
            Spacer()
            Button("Stop recording", action: recoderVM.stopRecording)
            Spacer()
        }
        
    }
}

struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView()
    }
}
