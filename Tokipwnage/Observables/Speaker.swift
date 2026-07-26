//
//  Speaker.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI
import AVKit

class Speaker: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {

    /// Shared, UserDefaults-backed preferences (voice + autoSpeak). Plain `let`
    /// on purpose: `@ObservedObject` does nothing outside a View, and every
    /// `Preferences` instance reads the same @AppStorage keys.
    private let prefs = Preferences()

    /// Published so that UI can react to speech state
    @Published var isSpeaking = false

    /// The Speech Synth used for TTS.
    let synthesizer = AVSpeechSynthesizer()

    /// Single source of truth for whether speech can be produced right now.
    /// Speech is gated on the user having chosen a voice in Settings — with no
    /// voice we stay silent rather than speak in a wrong/default voice. The
    /// sandbox side of speech (mach-lookup for audioanalyticsd) is granted by
    /// the entitlement; this gate is the app-level policy on top of it.
    public var canSpeak: Bool { !prefs.selectedVoice.isEmpty }

    /// Whether a selected word should be spoken automatically on appear.
    public var autoSpeakEnabled: Bool { prefs.autoSpeak }

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    ///  Immediately speaks the word with the selected voice.
    ///     NOTE: If no voice is selected, does nnothing.
    public func speak(_ word:Vocabulary.Words) {
        speak(rawText: processed(word.rawValue))
    }

    public func speak(_ text: String) {
        speak(rawText: processed(text))
    }

    /// Stops speaking immediately.
    public func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }

    /// Builds an utterance from already-processed text, assigns the selected
    /// voice, and speaks it. Does nothing if no voice is selected.
    private func speak(rawText: String) {
        guard canSpeak else {
            return
        }

        let utterance = AVSpeechUtterance(string: rawText)
        let voice = AVSpeechSynthesisVoice(identifier: prefs.selectedVoice)

        // Assign the voice to the utterance.
        utterance.voice = voice
        synthesizer.speak(utterance)
    }

    ///  returns a form of the word the MX voice will pronouce propelry for Toki Pona
    public func processed(_ word:String) -> String {
        return word.replacingOccurrences(of: "j", with: "ll")
    }

    // MARK: - AVSpeechSynthesizerDelegate

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = true
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }
}
