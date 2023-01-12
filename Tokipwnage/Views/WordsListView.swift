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
    @State var isShowingPrefs = false
    
    var searchField: some View {
        TextField("Search", text: $provider.searchString,
                  prompt: Text("Search words"))
        .onChange(of: provider.searchString) { newValue in
            provider.loadSearch(s: newValue)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading,
               content: {
            HStack {
                Text("Words")
                    .font(.title)
               NavigationLink(destination: PreferencesView(),
                              label: {Image(systemName: "gear")})
               
            }
            searchField
            
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

