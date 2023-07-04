//
//  PlaySound.swift
//  TodoList_MVPR
//
//  Created by Jason Ta on 2023-06-21.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        }
        catch {
            print("Could not find sound file.")
        }
    }
}
