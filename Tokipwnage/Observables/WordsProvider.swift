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
public class WordsProvider:ObservableObject {
    
    enum SearchCategory:String, CaseIterable, Codable {
        case word
        case meanings
        func string() -> String {
            switch self {
            case .word:
                return "word"
            case.meanings:
                return "meaning"
            }
        }
    }
    
    @Published var category:SearchCategory = .word
    
    /// the published word list
    @Published var words = [Vocabulary.Words]()
    
    /// the published search string
    @Published var searchString = ""
    
    /// Sets words to all words in the vocabulary containing the published search string.
    public func loadSearch() {
        words = Vocabulary.Words.allCases
                                .filter({ word in
                                    word.rawValue.contains(searchString)
        })
    }
    
    /// Sets the published words  to all words in the vocabulary containing a supplied string instead of the published search string.
    public func loadSearch(s:String) {
        
        guard !s.isEmpty else { loadAllWords();return}
        
        words = Vocabulary.Words.allCases
                                .filter({ word in
                                    switch category {
                                    case .word:
                                        return word.rawValue.contains(s)
                                    case .meanings:
                                        // discard cuz i dont want defs, i want words
                                        var found = false
                                        for def in word.definitions {
                                            if def.meaning.contains(s) {
                                                found = true
                                            }
                                        }
                                        return found
                                    }
        })
    }
    
    /// Sets the published words to  all words defined in Vocabulary.
    public func loadAllWords() {
        words = Vocabulary.Words.allCases
    }
}
