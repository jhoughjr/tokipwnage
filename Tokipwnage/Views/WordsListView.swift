//
//  WordsListView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordListView: View {
    var navigable = true
    @ObservedObject var provider:WordsProvider
    
    var body: some View {
        VStack(alignment: .leading,
               content: {
            Text("Words")
                .font(.title)
            List {
                ForEach(provider.words, id:\.rawValue) { word in
                    if navigable {
                        NavigationLink(word.rawValue, destination: WordView(word: word))
                    }else {
                        Text(word.rawValue)
                    }
                }
            }
        })
    }
}

