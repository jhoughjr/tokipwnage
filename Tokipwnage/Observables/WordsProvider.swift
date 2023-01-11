//
//  WordsProvider.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI
///      WordsProvider maintains an pyblished list of vocabulary words and a published search string.
///      It can load a search to the published list based on the published search string
///      Or it can load all words in the Vocabulary.
///      maybe i could abstract a protocol
///
public class WordsProvider:ObservableObject {
    
    /// the published word list
    @Published var words = [Vocabulary.Words]()
    
    /// the published search string
    @Published var searchString = ""
    
    public func loadSearch() {
        words = Vocabulary.Words.allCases
                                .filter({ word in
                                    word.rawValue.contains(searchString)
        })
    }
    
    /// loads words with a supplied string instead of the published search string into the published word list.
    public func loadSearch(s:String) {
        words = Vocabulary.Words.allCases
                                .filter({ word in
                                    word.rawValue.contains(s)
        })
    }
    
    /// Loads all words defined in Vocabulary into published word list.
    public func loadAllWords() {
        words = Vocabulary.Words.allCases
    }
}
