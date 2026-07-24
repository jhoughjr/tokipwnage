//
//  PartsOfSpeech+Color.swift
//  Tokipwnage
//

import SwiftUI

extension Vocabulary.Words.PartsOfSpeech {
    var color: Color {
        switch self {
        case .noun:         return .blue
        case .verb:         return .red
        case .adjective:    return .green
        case .particle:     return .purple
        case .preverb:      return .orange
        case .preposition:  return .teal
        case .number:       return .yellow
        case .interjection: return .pink
        }
    }
}
