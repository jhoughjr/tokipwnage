//
//  ContentView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var wordProvider = WordsProvider()
    @State var isShowingPrefs = false
    
    var body: some View {
        NavigationView {
            WordListView(provider: wordProvider, navigable: true)
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
