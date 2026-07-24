//
//  WordView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordView: View {
    let word:Vocabulary.Words
    @EnvironmentObject var speaker: Speaker
    @EnvironmentObject var prefs: Preferences
    @EnvironmentObject var favorites: FavoritesStore
    @ObservedObject var provider:WordsProvider

    @State private var showVoiceAlert = false

    private func filteredFor(part:Vocabulary.Words.PartsOfSpeech) -> [Vocabulary.Words.Definition] {
        word.definitions.filter({$0.partOfSpeech == part})
    }

    private func splitFor(string:String, search:String) -> (String,String,String) {
        let chunks = string.components(separatedBy: search)
        return (chunks.first!,search,chunks.last!)
    }

    private let orderedPartsOfSpeech:[Vocabulary.Words.PartsOfSpeech] = [.noun,
                                                                         .verb,
                                                                         .preverb,
                                                                         .preposition,
                                                                         .particle,
                                                                         .adjective,
                                                                         .number,
                                                                         .interjection]
    func orderedParts(for word:Vocabulary.Words) -> [Vocabulary.Words.PartsOfSpeech] {
        var o = [Vocabulary.Words.PartsOfSpeech]()
        for part in orderedPartsOfSpeech {
            if word.partsOfSpeech.contains(part) {
                o.append(part)
            }
        }
        return o
    }

    @ViewBuilder
    private func meaningViewForMatch(meaning:String,
                             search:String) -> some View {
        let triple = splitFor(string: meaning,
                              search: search)
        HStack(alignment: .top, spacing: 0) {
            Text(triple.0)
            Text(triple.1)
                .background(Color.accentColor.opacity(0.25))
            Text(triple.2)
        }
    }

    @ViewBuilder
    private func definitionView(_ definition: Vocabulary.Words.Definition) -> some View {
        Text(definition.meaning)
            .fontWeight(.ultraLight)
            .strikethrough(definition.depracated)
            .foregroundColor(definition.depracated ? .secondary : .primary)
    }

    private var partOfSpeechSortedList: some View {
        List {
            ForEach(orderedParts(for: word),
                    id:\.self) { part in
                VStack(alignment:.leading, spacing: 8) {
                    HStack(spacing: 6) {
                        Circle()
                            .fill(part.color)
                            .frame(width: 10, height: 10)
                            .accessibilityHidden(true)
                        Text(part.rawValue)
                            .bold()
                            .italic()
                            .foregroundColor(part.color)
                    }
                    VStack(alignment:.leading) {
                        Text("\(filteredFor(part:part).count) \(filteredFor(part:part).count == 1 ? "meaning":"meanings")")
                            .fontWeight(.ultraLight)
                        Divider()
                            .frame(width: 80)
                        ForEach(filteredFor(part: part),
                                id:\.self) { definition in
                            if definition.meaning.contains(provider.searchString) && provider.category == .meanings {
                                meaningViewForMatch(meaning: definition.meaning,
                                                    search: provider.searchString)
                            } else {
                                definitionView(definition)
                            }
                        }
                    }
                    .padding([.leading], 24)
                }
                .padding([.leading],0)
            }
        }
    }

    private var headingSummary: some View {
        HStack {
            Text("\(word.partsOfSpeech.count)")
                .bold()
            Text("parts of speech")
                .fontWeight(.ultraLight)
            Text("\(word.definitions.count)")
                .bold()
            Text("meanings")
                .fontWeight(.ultraLight)
        }
    }

    private var headingView: some View {
        HStack {
            Text(word.rawValue)
                .font(.title)
            Button {
                if prefs.selectedVoice.isEmpty {
                    showVoiceAlert = true
                } else {
                    speaker.speak(word)
                }
            } label: {
                Image(systemName: "speaker.wave.3")
            }
            .buttonStyle(PlainButtonStyle())
            Button {
                favorites.toggle(word)
            } label: {
                Image(systemName: favorites.isFavorite(word) ? "star.fill" : "star")
                    .foregroundColor(favorites.isFavorite(word) ? .yellow : .primary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Text(favorites.isFavorite(word) ? "Remove favorite" : "Add favorite"))
            headingSummary
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            headingView
            Divider()
            partOfSpeechSortedList
        }
        .onAppear {
            if prefs.autoSpeak {
                speaker.speak(word)
            }
        }
        .alert("No Voice Selected", isPresented: $showVoiceAlert) {
            Button("OK") {}
        } message: {
            Text("Select a voice in Settings to enable speech.")
        }
    }
}
