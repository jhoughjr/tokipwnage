//
//  Speaker.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI
import AVKit

class Speaker:ObservableObject {
    
    /// Globalized via @AppStorage
    ///  Used to get selected voice.
    @ObservedObject var prefs = Preferences()
    
    /// Published so that UI can react to speech state
    @Published var isSpeaking = false
    
    /// The Speech Synth used for TTS.
    let synthesizer = AVSpeechSynthesizer()

    ///  Immediately speaks the word with the selected voice.
    ///     NOTE: If no voice is selected, does nnothing.
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
    
    ///  returns a form of the word the MX voice will pronouce propelry for Toki Pona
    public func processed(_ word:String) -> String {
        return word.replacingOccurrences(of: "j", with: "ll")
    }
}
