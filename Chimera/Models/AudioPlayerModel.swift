//
//  AudioPlayerModel.swift
//  Chimera
//
//  Created by Antonella Giugliano on 13/01/23.
//

import Foundation
import AVFoundation
import SwiftUI
import Combine

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    
    //notify changes to observing views like when recording starts
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    //to create an AVAudioPlayer instance for the playing
    var audioPlayer: AVAudioPlayer!
    
    
    //notifies the view about the changing by the objectWillChange property
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    //func to play the record
    func startPlayback (audio: URL) {
        
        // initialize a playback session
        let playbackSession =  AVAudioSession.sharedInstance()
        
        //overwrite the output audio port to make the sound be played by the loudspeaker
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        //to start playing the record
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            //notify the view that the playing has just started
            isPlaying = true
        } catch{
            print("Playback failed.")
        }
    }
    
    //func to stop the playing of the record
    func stopPlayback() {
        audioPlayer.stop()
        //notifying the view that the playing has been stopped
        isPlaying = false
    }
    
    //func to notify the view that the playing is over and set back the playing properties values to false
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}
