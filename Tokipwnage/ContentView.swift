//
//  ContentView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordListView: View {
    var navigable = true
    
    var body: some View {
        VStack(alignment: .leading,
               content: {
            Text("Words")
                .font(.title)
            List {
                ForEach(Vocabulary.Words.allCases, id:\.rawValue) { word in
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

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            WordListView(navigable: true)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
