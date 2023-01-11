//
//  Toki.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import Foundation
public class Vocabulary {
    public enum NumberSystem {
        case simple
        case complex
    }
    
    public enum Words:String, CaseIterable, Codable {
        
        public enum PartsOfSpeech:String, CaseIterable, Codable {
            case noun
            case particle
            case adjective
            case verb
            case preverb
            case number
            
        }
        
        public struct Definition:Codable, Hashable {
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
        
        public var definitions:[Definition] {
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
            case .anpa:
                return [Definition(.verb,
                                   "to bow down"),
                        Definition(.verb,
                                   "to conquer"),
                        Definition(.verb,
                                   "to defeat"),
                        Definition(.noun,
                                   "lower part",
                                   isDeprecated: true),
                        Definition(.adjective,
                                   "bowing down"),
                        Definition(.adjective,
                                   "downward"),
                        Definition(.adjective,
                                   "lowly"),
                        Definition(.adjective,
                                   "dependent"),
                        Definition(.adjective,
                                   "humble")
                        ]
            case .ale:
                return  [Definition(.noun,
                                    "everything"),
                         Definition(.noun,
                                    "universe"),
                         Definition(.adjective,
                                    "every"),
                         Definition(.adjective,
                                    "all"),
                         Definition(.adjective,
                                    "abundant"),
                         Definition(.number,
                                    "infinity"),
                         Definition(.number,
                                    "one hundred")
                         ]
            
            case .ali:
                return Words.ale.definitions
            
            case .ante:
                return [Definition(.verb,"to change"),
                        Definition(.noun,"change", isDeprecated: true),
                        Definition(.noun,"difference"),
                        Definition(.adjective,"different"),
                        Definition(.adjective,"other"),
                        Definition(.adjective,"changed")]
            case .anu:
                return [Definition(.particle,"or")]
                
            case .awen:
                return [Definition(.noun,"safety"),
                        Definition(.noun,"wait"),
                        Definition(.noun,"stabillity", isDeprecated: true),
                        Definition(.adjective,"kept"),
                        Definition(.adjective,"safe"),
                        Definition(.adjective,"enduring"),
                        Definition(.adjective,"resilient"),
                        Definition(.adjective,"waiting"),
                        Definition(.adjective,"staying"),
                        Definition(.verb,"keep"),
                        Definition(.verb,"endure"),
                        Definition(.verb,"stay"),
                        Definition(.verb,"protect"),
                        Definition(.preverb,"continue doing")
                ]
            }
        }
        
        case a
        case akesi
        case ala
        case alasa
        case ale
        case ali
        case anpa
        case ante
        case anu
        case awen
    }
}
