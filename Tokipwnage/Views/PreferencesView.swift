//
//  Preferences.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI
import AVKit


struct PreferencesView: View {
    @EnvironmentObject var prefs: Preferences

    @State private var filterText = ""
    @State private var genderFilter: AVSpeechSynthesisVoiceGender? = nil

    private func stringFor(_ gender: AVSpeechSynthesisVoiceGender) -> String {
        switch gender {
        case .male:        return "male"
        case .female:      return "female"
        case .unspecified: return "neuter"
        @unknown default:  return "???"
        }
    }

    private var filteredVoices: [AVSpeechSynthesisVoice] {
        AVSpeechSynthesisVoice.speechVoices().filter { voice in
            let matchesText = filterText.isEmpty
                || voice.language.localizedCaseInsensitiveContains(filterText)
                || voice.name.localizedCaseInsensitiveContains(filterText)
            let matchesGender = genderFilter == nil || voice.gender == genderFilter
            return matchesText && matchesGender
        }
    }

    private var filterBar: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("Filter by name or language (e.g. es-MX)",
                      text: $filterText)
                .textFieldStyle(.roundedBorder)

            HStack(spacing: 8) {
                Text("Gender:")
                    .foregroundColor(.secondary)
                    .font(.caption)
                ForEach([nil, .male, .female, .unspecified] as [AVSpeechSynthesisVoiceGender?],
                        id: \.self) { option in
                    let label = option == nil ? "all" : stringFor(option!)
                    let selected = genderFilter == option
                    Button(label) {
                        genderFilter = option
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.mini)
                    .tint(selected ? .accentColor : .secondary)
                }
                Spacer()
                Text("\(filteredVoices.count) voices")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Voices")
                .font(.headline)
                .padding(.horizontal)
            HStack {
                Toggle(isOn: prefs.$autoSpeak) {
                    Text("AutoSpeak")
                }
                Text("Note that es-MX voices are best at approximating the correct pronunciation and using other voices may sound incorrect.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            Group {
                if !prefs.selectedVoice.isEmpty,
                   let voice = AVSpeechSynthesisVoice(identifier: prefs.selectedVoice) {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("\(voice.name) · \(voice.language)")
                    }
                } else {
                    HStack(spacing: 6) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.orange)
                        Text("No voice selected")
                    }
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal)

            filterBar

            List {
                ForEach(filteredVoices, id: \.identifier) { voice in
                    HStack {
                        if !prefs.selectedVoice.isEmpty
                           && prefs.selectedVoice == voice.identifier {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                        Text(voice.name)
                        Text(stringFor(voice.gender))
                            .italic()
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(voice.language)
                            .fontWeight(.ultraLight)
                            .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        if prefs.selectedVoice != voice.identifier {
                            prefs.selectedVoice = voice.identifier
                        } else {
                            prefs.selectedVoice = ""
                        }
                    }
                }
            }
            Spacer()
        })
    }
}
