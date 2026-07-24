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

    var body: some View {
        NavigationStack {
            WordListView(provider: wordProvider,
                         navigable: true)
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
            .environmentObject(Speaker())
            .environmentObject(Preferences())
            .environmentObject(FavoritesStore())
    }
}
