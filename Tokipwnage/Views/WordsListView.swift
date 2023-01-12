//
//  WordsListView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordListView: View {
    
    @ObservedObject var provider:WordsProvider
    @State var isShowingPrefs = false
    @State var navigable = true
    
    private var searchSelector: some View {
        Picker(selection: $provider.category) {
            Text("word")
                .tag(WordsProvider.SearchCategory.word)
            Text("meaning")
                .tag(WordsProvider.SearchCategory.meanings)
        } label: {
            Text("Searching...")
        }

    }
    
    private var searchField: some View {
        TextField("Search",
                  text: $provider.searchString,
                  prompt: Text("Search \($provider.category.wrappedValue.string())"))
        
        .onChange(of: provider.searchString) { newValue in
            provider.loadSearch(s: newValue)
        }
    }
    
    private var title: some View {
        HStack {
            Text("Words")
                .font(.title)
           NavigationLink(destination: PreferencesView(),
                          label: {Image(systemName: "gear")})
           
        }
    }
    
    private var list: some View {
        List {
            ForEach(provider.words, id:\.rawValue) { word in
                if navigable {
                    NavigationLink(word.rawValue,
                                   destination: WordView(word: word,
                                                         provider: provider))
                    
                }else {
                    Text(word.rawValue)
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading,
               content: {
            title
            searchField
            searchSelector
            list
        })
        .padding()
    }
}

