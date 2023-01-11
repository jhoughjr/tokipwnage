//
//  WordsProvider.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

public class WordsProvider:ObservableObject {
    @Published var words = [Vocabulary.Words]()
    @Published var searchString = ""
    
    public func loadSearch() {
        words = Vocabulary.Words.allCases
                                .filter({ word in
                                    word.rawValue.contains(searchString)
        })
    }
    
    public func loadAllWords() {
        words = Vocabulary.Words.allCases
    }
}
