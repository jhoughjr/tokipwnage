//
//  Preferences.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI
import AVKit


struct PreferencesView: View {
    @ObservedObject var prefs = Preferences()
    
    func stringFor(_ gender:AVSpeechSynthesisVoiceGender) -> String {
        switch gender {
        case .male:
            return "male"
        case .female:
            return "female"
        case .unspecified:
            return "neuter"
        @unknown default:
            return "???"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading,
               content: {
            Text("Voices")
            Toggle(isOn: prefs.$autoSpeak) {
                Text("AutoSpeak")
            }
            List {
                ForEach(AVSpeechSynthesisVoice.speechVoices(), id:\.identifier) { voice in
                    HStack {
                        if !prefs.selectedVoice.isEmpty
                           && prefs.selectedVoice == voice.identifier {
                            Image(systemName: "checkmark")
                        }
                        Text("\(voice.name)")
                        Text(stringFor(voice.gender))
                            .italic()
                        Text("\(voice.language)")
                            .fontWeight(.ultraLight)
                    }
                    .onTapGesture {
                        if prefs.selectedVoice != voice.identifier {
                            prefs.selectedVoice = voice.identifier
                        }
                        else {
                            prefs.selectedVoice = ""
                        }
                    }
                }
            }
            Spacer()
            
        })
    }
}
