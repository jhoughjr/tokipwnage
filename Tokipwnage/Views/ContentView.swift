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
            // The sidebar needs a stack of its own. `.searchable` renders its field into
            // the enclosing navigation bar, and the links in `WordListView`'s title bar
            // need somewhere to push; with no stack here both silently do nothing. The
            // Mac hosts them in the window toolbar regardless, which is why this only
            // ever went missing on iOS.
            NavigationStack {
                WordListView(provider: wordProvider,
                             selection: $selectedWord)
                .onAppear {
                    wordProvider.loadAllWords()
                }
                #if os(iOS)
                // No title of its own — `WordListView` draws one. Inline keeps the bar a
                // thin host for the search field rather than a tall empty header.
                .navigationBarTitleDisplayMode(.inline)
                #endif
            }
            .navigationSplitViewColumnWidth(min: 280, ideal: 320)
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
