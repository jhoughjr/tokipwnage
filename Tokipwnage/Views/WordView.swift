//
//  WordView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordView: View {
    let word:Vocabulary.Words
    
    var redundantList: some View {
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
    
    var partOfSpeechSortedList: some View {
        
        List {
            ForEach(word.partsOfSpeech,
                    id:\.self) { part in
                
                HStack(alignment:.top) {
                    VStack(alignment:.leading) {
                        Text(part.rawValue)
                            .bold()
                        Spacer()
                    }
                    VStack(alignment:.leading) {
                            ForEach(word.definitions.filter({$0.partOfSpeech == part}),
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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(word.rawValue)
                .font(.title)
            partOfSpeechSortedList
        }
        .padding()
    }
}

