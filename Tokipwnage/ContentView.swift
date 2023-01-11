//
//  ContentView.swift
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

class WordsProvider:ObservableObject {
    @Published var words = [Vocabulary.Words]()
    @Published var searchString = ""
    
    func loadSearch() {
        words = Vocabulary.Words.allCases
                                .filter({ word in
                                    word.rawValue.contains(searchString)
        })
    }
    
    func loadAllWords() {
        words = Vocabulary.Words.allCases
    }
}

struct ContentView: View {
    
    @ObservedObject var wordProvider = WordsProvider()
    
    var body: some View {
        NavigationView {
            WordListView(navigable: true,
                         provider: wordProvider)
            .onAppear {
                wordProvider.loadAllWords()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
