//
//  Speaker.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI
import AVKit

class Speaker:ObservableObject {
    @ObservedObject var prefs = Preferences()
    
    @Published var isSpeaking = false
    let synthesizer = AVSpeechSynthesizer()

    public func speak(_ word:Vocabulary.Words) {
        // Create an utterance.
        guard  !prefs.selectedVoice.isEmpty else {
            return
        }
        
        let utterance = AVSpeechUtterance(string: processed(word.rawValue))
        let voice = AVSpeechSynthesisVoice(identifier: prefs.selectedVoice)

        // Assign the voice to the utterance.
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
    
    func processed(_ word:String) -> String {
        return word.replacingOccurrences(of: "j", with: "ll")
    }
}
