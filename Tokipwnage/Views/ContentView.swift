//
//  ContentView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var wordProvider = WordsProvider()
    @State var isShowingPrefs = false
    @State private var selectedWord: Vocabulary.Words?

    var body: some View {
        NavigationSplitView {
            WordListView(provider: wordProvider,
                         selection: $selectedWord)
            .onAppear {
                wordProvider.loadAllWords()

            }
        } detail: {
            NavigationStack {
                if let selectedWord {
                    WordView(word: selectedWord, provider: wordProvider)
                } else {
                    wordPlaceholder
                }
            }
        }
    }

    private var wordPlaceholder: some View {
        VStack(spacing: 8) {
            Image(systemName: "character.book.closed")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("Select a word")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Speaker())
            .environmentObject(Preferences())
            .environmentObject(FavoritesStore())
    }
}
