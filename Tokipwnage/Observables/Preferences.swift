//
//  Preferences.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

class Preferences:ObservableObject {
    /// Stores the user selected voice identifier as a string in App Storage.
    @AppStorage("selected_voice") var selectedVoice = ""
    /// Selects whether a word is spoken upon selection or not.
    @AppStorage("autoSpeak") var autoSpeak = true
}

/// Stores the user's favorited words, persisted to UserDefaults as an array of raw values.
final class FavoritesStore: ObservableObject {
    private let key = "favoriteWords"
    @Published var rawValues: Set<String> {
        didSet { UserDefaults.standard.set(Array(rawValues), forKey: key) }
    }
    init() {
        rawValues = Set(UserDefaults.standard.stringArray(forKey: key) ?? [])
    }
    func isFavorite(_ word: Vocabulary.Words) -> Bool { rawValues.contains(word.rawValue) }
    func toggle(_ word: Vocabulary.Words) {
        if rawValues.contains(word.rawValue) { rawValues.remove(word.rawValue) }
        else { rawValues.insert(word.rawValue) }
    }
    var favorites: [Vocabulary.Words] {
        Vocabulary.Words.allCases.filter { rawValues.contains($0.rawValue) }
    }
}

