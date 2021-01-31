//
//  MusicManager.swift
//  AppEase WatchKit Extension
//
//  Created by Vidit Bhargava on 12/7/20.
//

import Foundation
import AVFoundation

class MusicManager {
    
    let session = AVAudioSession.sharedInstance()
    var player: AVAudioPlayer = AVAudioPlayer()
    
    init() {
        setupAudioSession()
    }
    
    func setupAudioSession() {
        // Set up the session.
        do {
            try session.setCategory(AVAudioSession.Category.playback,
                                    mode: .default,
                                    policy: .longFormAudio,
                                    options: [])
        } catch let error {
            fatalError("*** Unable to set up the audio session: \(error.localizedDescription) ***")
        }
    }
    
    func setupAudioPlayer(fileName: String) {
        // Set up the player
        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("*** Unable to set up the audio player: \(error.localizedDescription) ***")
            // Handle the error here.
            return
        }
    }
    
    func activateAudioSession() {
        // Activate and request the route.
        session.activate(options: []) { (success, error) in
            guard error == nil else {
                print("*** An error occurred: \(error!.localizedDescription) ***")
                // Handle the error here.
                return
            }
            
            // Play the audio file.
            self.player.play()
        }
    }
    
    func stopPlayingAudio() {
        // Activate and request the route.
        self.player.pause()
    }
    
}
