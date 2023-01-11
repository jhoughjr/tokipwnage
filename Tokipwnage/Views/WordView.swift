//
//  WordView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordView: View {
    let word:Vocabulary.Words
    
    func filteredFor(part:Vocabulary.Words.PartsOfSpeech) -> [Vocabulary.Words.Definition] {
        word.definitions.filter({$0.partOfSpeech == part})
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
            ForEach(word.partsOfSpeech,
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
                                Text(word.meaning)
                                    .fontWeight(.ultraLight)
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
    }
}

