//
//  WordView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordView: View {
    let word:Vocabulary.Words
    var body: some View {
        VStack(alignment: .leading) {
            Text(word.rawValue)
                .font(.title)
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
        .padding()
    }
}

