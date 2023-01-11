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
    
    var body: some View {
        VStack(alignment: .leading,
               content: {
            HStack {
                Text("Words")
                    .font(.title)
               NavigationLink(destination: PreferencesView(),
                              label: {Image(systemName: "gear")})
               
            }
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

