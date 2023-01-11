//
//  Toki.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import Foundation
class Vocabulary {
enum Words:String, CaseIterable, Codable {
    
    enum PartsOfSpeech:String, CaseIterable, Codable {
        case noun
        case particle
        case adjective
        case verb
        case preverb
        case number
        
    }
    
    struct Definition:Codable, Hashable {
        let partOfSpeech:PartsOfSpeech
        let meaning:String
        let depracated:Bool
        
        init(_ part:PartsOfSpeech, _ meaning:String) {
            self.partOfSpeech = part
            self.meaning = meaning
            self.depracated = false
        }
        
        init(_ part:PartsOfSpeech, _ meaning:String, isDeprecated:Bool = false) {
            self.partOfSpeech = part
            self.meaning = meaning
            self.depracated = isDeprecated
        }
    }
    
    var definitions:[Definition] {
        switch self {
        case .a:
            return [Definition(.particle,
                               "confirmation"),
                    Definition(.particle,
                               "emphasis"),
                    Definition(.particle,
                               "emotional interjection")
                    ]
        case .akesi:
            return [Definition(.noun,
                               "lizard"),
                    Definition(.noun,
                               "reptile"),
                    Definition(.noun,
                               "non-cute animal",
                              isDeprecated: true)
                    ]
        case .ala:
            return [Definition(.noun,
                               "nothing"),
                    Definition(.adjective,
                               "not"),
                    Definition(.adjective,
                               "no"),
                    Definition(.adjective,
                               "empty"),
                    Definition(.number,
                               "0")
                    ]
        case .alasa:
            return [Definition(.verb,
                               "to hunt"),
                    Definition(.verb,
                               "to gather"),
                    Definition(.verb,
                               "to search"),
                    Definition(.verb,
                               "to look for"),
                    Definition(.preverb,
                               "to try to do")
                    ]
        }
    }
    
    case a
    case akesi
    case ala
    case alasa
}
}
