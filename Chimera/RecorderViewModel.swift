//
//  RecorderViewModel.swift
//  Chimera
//
//  Created by Simon Bestler on 11.01.23.
//

import Foundation
import AVFoundation

class RecorderViewModel : ObservableObject {
    
    private var audioRecorder : AVAudioRecorder!
    @Published var isRecording : Bool
    
    private let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    init() {
        self.isRecording = false
        self.audioRecorder = nil
    }
        
    func startRecording(){
        isRecording = true
        let date = Date().formatted()
        let path = URL.documentsDirectory
        //TODO: Store it in a directory related to the event
        let fileName = path.appendingPathComponent("Recording - \(date).m4a")
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Can not setup the Recording")
        }
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
                audioRecorder.prepareToRecord()
                audioRecorder.record()
        } catch {
            print("Failed to start recording!")
        }
    }
    
    func stopRecording(){
        isRecording = false
        audioRecorder.stop()
    }
    
}
