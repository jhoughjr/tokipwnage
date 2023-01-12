//
//  WordView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordView: View {
    let word:Vocabulary.Words
    @ObservedObject var speaker = Speaker()
    @ObservedObject var prefs = Preferences()
    @ObservedObject var provider:WordsProvider
    
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
                                                                         .particle,
                                                                         .adjective,
                                                                         .number]
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
        HStack(alignment: .center, spacing: 0) {
            Text(triple.0)
            Text(triple.1)
                .foregroundColor(.green)
            Text(triple.2)
        }
    }
    
    @ViewBuilder
    private func meaingViewfor(_ meaning:String) -> some View {
        Text(meaning)
            .fontWeight(.ultraLight)
    }
    
    private var redundantList: some View {
        List {
            ForEach(word.definitions,
                    id:\.self) { definition in
                HStack {
                    Text(definition.partOfSpeech.rawValue)
                        .bold()
                        .italic()
                    Text(definition.meaning)
                        .fontWeight(.light)
                        
                }
            }
        }
    }
    
    private var partOfSpeechSortedList: some View {
        
        List {
            ForEach(orderedParts(for: word),
                    id:\.self) { part in
                
                HStack(alignment:.top) {
                    VStack(alignment:.leading) {
                        Text(part.rawValue)
                            .bold()
                        Text("\(filteredFor(part:part).count) \(filteredFor(part:part).count == 1 ? "meaning":"meanings")")
                            .fontWeight(.ultraLight)
                        Spacer()
                    }
                    
                    VStack(alignment:.leading) {
                        ForEach(filteredFor(part: part),
                                id:\.self) { word in
                            
                            if word.meaning.contains(provider.searchString) {
                                meaningViewForMatch(meaning: word.meaning,
                                                    search: provider.searchString)
                            }else {
                                meaingViewfor(word.meaning)
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
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
                speaker.speak(word)
            } label: {
                Image(systemName: "speaker.wave.3")
            }
            .buttonStyle(PlainButtonStyle())
          headingSummary
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headingView
            Divider()
            partOfSpeechSortedList
        }
        .padding()
        .onAppear {
            if prefs.autoSpeak {
                speaker.speak(word)
            }
        }
    }
}

