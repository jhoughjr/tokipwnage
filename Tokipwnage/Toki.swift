//
//  Toki.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import Foundation

/// Encapsulates a model of Toki Pona
public class Vocabulary {
    
    /// Identifies which number system a definition is used.
    public enum NumberSystem {
        case simple
        case complex
    }
    
    /// The heart of the vocabulary.
    /// an enumerated word has definitions and parts of speech it can be used as.
    public enum Words:String, CaseIterable, Codable {
        
        /// Enumerates how you can use words according to synax.
        public enum PartsOfSpeech:String, CaseIterable, Codable {
            case noun
            case particle
            case adjective
            case verb
            case preverb
            case preposition
            case number
            case interjection

        }
        
        /// Composes of the part of speech and the meanings o words.
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
        
        /// Every definition of a word consiting of its part of speech and meaing as aforementioned part.
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
            case .e:
                return [Definition(.particle, "a")]
            case .en:
                return [Definition(.particle, "and")]
            case .epiku:
                return [Definition(.adjective, "awesome")]
            case .esun:
                return [Definition(.adjective, "commercial"),
                        Definition(.verb, "to trade"),
                        Definition(.verb, "to exhange"),
                        Definition(.noun, "trade"),
                        Definition(.noun, "transaction"),
                        Definition(.noun, "exhange")]
            case .ijo:
                return [Definition(.adjective, "physical"),
                        Definition(.adjective, "material"),
                        Definition(.noun, "thing"),
                        Definition(.noun, "object"),
                        Definition(.noun, "matter")]
            case .ike:
                return [Definition(.noun, "evil"),
                        Definition(.adjective, "evil"),
                        Definition(.adjective, "complex"),
                        Definition(.adjective, "unneccesary"),
                        Definition(.verb, "to make worse", isDeprecated: true)
                        ]
            case .ilo:
                return [Definition(.noun, "tool"),
                        Definition(.noun, "machine"),
                        Definition(.noun, "device"),
                        Definition(.adjective, "useful"),
                        Definition(.adjective, "metallic"),
                        Definition(.adjective, "electronic",isDeprecated: true),

                        ]
            case .insa:
                return [Definition(.noun, "insides"),
                        Definition(.noun, "center"),
                        Definition(.noun, "contents"),
                        Definition(.noun, "stomach"),
                        Definition(.adjective, "central"),
                        Definition(.adjective, "inside"),
                        Definition(.adjective, "between"),
                        ]
            case .jaki:
                return [Definition(.noun,"dirt"),
                        Definition(.noun,"waste"),
                        Definition(.adjective,"dirty"),
                        Definition(.adjective,"toxic"),
                        Definition(.adjective,"unclean"),
                        Definition(.adjective,"unsanitary"),
                        Definition(.adjective,"disgusting"),
                        Definition(.verb,"to make something dirty")]
            case .jan:
                return [Definition(.noun,"person"),
                        Definition(.noun,"people"),
                        Definition(.noun,"humanity"),
                        Definition(.noun,"someone"),
                        Definition(.adjective,"human-like"),
                        Definition(.adjective,"personal")]
            case .jasima:
                return [Definition(.noun,"mirror"),
                        Definition(.noun,"reflection"),
                        Definition(.noun,"echo"),
                        Definition(.adjective,"opposite"),
                        Definition(.verb,"to reflect"),
                        Definition(.verb,"to reverse")]
            case .jelo:
                return [Definition(.noun,"the color yellow"),
                        Definition(.adjective,"yellowish"),
                        Definition(.verb,"to make yellow"),
                        ]
            case .jo:
                return [Definition(.noun,"property"),
                        Definition(.noun,"posessions", isDeprecated: true),
                        Definition(.verb,"to have"),
                        Definition(.verb,"to carry"),
                        Definition(.verb,"to contain"),
                        Definition(.verb,"to hold"),
                        ]
            case .kala:
                return [ Definition(.noun,"sea creature"),
                         Definition(.noun,"fish"),
                         Definition(.noun,"marine animal"),]
            case .kalama:
                return [ Definition(.noun,"sound"),
                         Definition(.noun,"noise"),
                         Definition(.adjective,"loud"),
                         Definition(.adjective,"noisy"),
                         Definition(.adjective,"sound making"),
                         Definition(.verb,"to make noise"),
                         Definition(.verb,"to recite"),
                         Definition(.verb,"to play a musical instrument"),
                         ]
            case .kama:
                return [ Definition(.noun,"event"),
                         Definition(.noun,"arrival"),
                         Definition(.adjective,"arriving"),
                         Definition(.adjective,"coming"),
                         Definition(.adjective,"future"),
                         Definition(.adjective,"summoned"),

                         Definition(.preverb,"to become"),
                         Definition(.preverb,"to be in the process of doing"),
                         Definition(.preverb,"to manage to do"),
                         Definition(.preverb,"to succeed in"),
                         ]
            case .kasi:
                return [Definition(.noun,"plant"),
                        Definition(.noun,"grass"),
                        Definition(.noun,"herb"),
                        Definition(.noun,"leaf"),
                        ]
            case .ken:
                return [Definition(.noun,"abillity"),
                        Definition(.noun,"possibility"),
                        Definition(.noun,"liberty"),
                        Definition(.noun,"right", isDeprecated: true),
                        Definition(.preverb,"can"),
                        Definition(.preverb,"may"),
                        Definition(.adjective,"possible"),
                        Definition(.adjective,"ability", isDeprecated: true),
                        ]
            case .kepeken:
                return [Definition(.noun, "use"),
                        Definition(.noun, "pracice", isDeprecated: true),
                        Definition(.verb, "to use"),
                        Definition(.preposition,"using"),
                        Definition(.preposition,"with help of")]
            case .kijetesantakalu:
                return [Definition(.noun, "racoon or other musteloid")]
            case .kili:
                return [Definition(.noun, "fruit"),
                        Definition(.noun, "vegetable"),
                        Definition(.noun, "mushrooms")]
            case .kin:
                return [Definition(.particle, "very"),
                        Definition(.particle, "really"),
                        Definition(.particle, "also")]
            case .kipisi:
                return [Definition(.verb, "to cut"),
                        Definition(.verb, "to divide")]
            case .kiwen:
                return [Definition(.noun, "hard object"),
                        Definition(.noun, "metal"),
                        Definition(.noun, "stone"),
                        Definition(.adjective, "hard"),
                        Definition(.adjective, "metallic"),
                        Definition(.adjective, "solid")]
            case .ko:
                return [Definition(.noun, "powder"),
                        Definition(.noun, "clay"),
                        Definition(.noun, "paste"),
                        Definition(.noun, "semi-solid")]
            case .kokosila:
                return [Definition(.verb, "to speak a language other than toki pona in a toki pona environment")]
            case .kon:
                return [Definition(.noun, "air"),
                        Definition(.noun, "essence"),
                        Definition(.noun, "spirit"),
                        Definition(.noun, "gas", isDeprecated: true),
                        Definition(.adjective, "invisible"),
                        Definition(.adjective, "ephemeral")]
            case .ku:
                return [Definition(.noun, "the Toki Pona Dictionary by Sonja Lang"),
                        Definition(.verb, "to interact with ku")]
            case .kule:
                return [Definition(.noun, "color"),
                        Definition(.noun, "gender", isDeprecated: true),
                        Definition(.adjective, "colorful"),
                        Definition(.adjective, "painted"),
                        Definition(.verb, "to paint a color")]
            case .kulupu:
                return [Definition(.noun, "group"),
                        Definition(.noun, "community"),
                        Definition(.noun, "company"),
                        Definition(.noun, "society"),
                        Definition(.noun, "nation"),
                        Definition(.noun, "tribe"),
                        Definition(.adjective, "communal"),
                        Definition(.adjective, "social")]
            case .kute:
                return [Definition(.noun, "ear"),
                        Definition(.noun, "hearing"),
                        Definition(.adjective, "...-sounding"),
                        Definition(.verb, "to hear"),
                        Definition(.verb, "to listen"),
                        Definition(.verb, "to obey")]
            case .la:
                return [Definition(.particle, "if/when (introduces context)")]
            case .lanpan:
                return [Definition(.verb, "to get"),
                        Definition(.verb, "to take"),
                        Definition(.verb, "to steal")]
            case .lape:
                return [Definition(.noun, "sleep"),
                        Definition(.noun, "rest"),
                        Definition(.adjective, "sleeping"),
                        Definition(.adjective, "restful"),
                        Definition(.verb, "to sleep"),
                        Definition(.verb, "to rest")]
            case .laso:
                return [Definition(.noun, "the color blue"),
                        Definition(.noun, "the color green"),
                        Definition(.adjective, "blue"),
                        Definition(.adjective, "green"),
                        Definition(.verb, "to color something blue/green")]
            case .lawa:
                return [Definition(.noun, "head"),
                        Definition(.noun, "mind"),
                        Definition(.adjective, "main"),
                        Definition(.adjective, "primary"),
                        Definition(.adjective, "controlling"),
                        Definition(.adjective, "ruling"),
                        Definition(.verb, "to head"),
                        Definition(.verb, "to control"),
                        Definition(.verb, "to direct"),
                        Definition(.verb, "to guide"),
                        Definition(.verb, "to lead"),
                        Definition(.verb, "to own"),
                        Definition(.verb, "to rule")]
            case .leko:
                return [Definition(.noun, "square"),
                        Definition(.noun, "block"),
                        Definition(.noun, "stairs")]
            case .len:
                return [Definition(.noun, "cloth"),
                        Definition(.noun, "clothes"),
                        Definition(.noun, "fabric"),
                        Definition(.noun, "layer of privacy"),
                        Definition(.adjective, "clothed"),
                        Definition(.adjective, "made of cloth/fabric"),
                        Definition(.verb, "to clothe"),
                        Definition(.verb, "to provide a layer of privacy")]
            case .lete:
                return [Definition(.noun, "cold"),
                        Definition(.adjective, "cold"),
                        Definition(.adjective, "cool"),
                        Definition(.adjective, "raw"),
                        Definition(.adjective, "uncooked"),
                        Definition(.verb, "to cool down")]
            case .li:
                return [Definition(.particle, "between subject and verb/adjective")]
            case .lili:
                return [Definition(.noun, "smallness"),
                        Definition(.adjective, "small"),
                        Definition(.adjective, "few"),
                        Definition(.adjective, "young"),
                        Definition(.verb, "to shrink")]
            case .linja:
                return [Definition(.noun, "long flexible object"),
                        Definition(.noun, "string"),
                        Definition(.noun, "rope"),
                        Definition(.noun, "hair")]
            case .lipu:
                return [Definition(.noun, "flat object"),
                        Definition(.noun, "book"),
                        Definition(.noun, "document"),
                        Definition(.noun, "paper"),
                        Definition(.noun, "page"),
                        Definition(.noun, "record"),
                        Definition(.noun, "website"),
                        Definition(.adjective, "flat"),
                        Definition(.adjective, "lipu-like")]
            case .loje:
                return [Definition(.noun, "the color red"),
                        Definition(.adjective, "red"),
                        Definition(.verb, "to color something red")]
            case .lon:
                return [Definition(.noun, "truth"),
                        Definition(.noun, "life"),
                        Definition(.noun, "existence"),
                        Definition(.adjective, "real"),
                        Definition(.adjective, "true"),
                        Definition(.adjective, "present"),
                        Definition(.adjective, "existing"),
                        Definition(.verb, "is true"),
                        Definition(.verb, "exists"),
                        Definition(.preposition, "in"),
                        Definition(.preposition, "at"),
                        Definition(.preposition, "on")]
            case .luka:
                return [Definition(.noun, "hand"),
                        Definition(.noun, "arm"),
                        Definition(.number, "5")]
            case .lukin:
                return [Definition(.noun, "eye"),
                        Definition(.noun, "vision"),
                        Definition(.adjective, "...-looking"),
                        Definition(.adjective, "visual"),
                        Definition(.verb, "to look"),
                        Definition(.verb, "to see"),
                        Definition(.verb, "to read"),
                        Definition(.preverb, "to seek to do something")]
            case .lupa:
                return [Definition(.noun, "hole"),
                        Definition(.noun, "door"),
                        Definition(.noun, "orifice"),
                        Definition(.noun, "window")]
            case .ma:
                return [Definition(.noun, "earth"),
                        Definition(.noun, "land"),
                        Definition(.noun, "outdoors"),
                        Definition(.noun, "territory"),
                        Definition(.noun, "country")]
            case .mama:
                return [Definition(.noun, "parent"),
                        Definition(.noun, "ancestor"),
                        Definition(.noun, "creator"),
                        Definition(.noun, "origin"),
                        Definition(.noun, "caretaker"),
                        Definition(.verb, "to create"),
                        Definition(.verb, "to parent"),
                        Definition(.verb, "to take care of")]
            case .mani:
                return [Definition(.noun, "money"),
                        Definition(.noun, "large domesticated animal"),
                        Definition(.adjective, "wealthy", isDeprecated: true)]
            case .meli:
                return [Definition(.noun, "woman"),
                        Definition(.noun, "female"),
                        Definition(.noun, "wife"),
                        Definition(.adjective, "feminine")]
            case .meso:
                return [Definition(.noun, "middle"),
                        Definition(.noun, "center"),
                        Definition(.adjective, "average"),
                        Definition(.adjective, "moderate"),
                        Definition(.adjective, "mediocre")]
            case .mi:
                return [Definition(.noun, "I, me"),
                        Definition(.noun, "we, us"),
                        Definition(.adjective, "my, our")]
            case .mije:
                return [Definition(.noun, "man"),
                        Definition(.noun, "male"),
                        Definition(.noun, "husband"),
                        Definition(.adjective, "masculine")]
            case .misikeke:
                return [Definition(.noun, "medicine"),
                        Definition(.noun, "cure"),
                        Definition(.adjective, "medicinal"),
                        Definition(.verb, "to cure")]
            case .moku:
                return [Definition(.noun, "food"),
                        Definition(.adjective, "edible"),
                        Definition(.adjective, "of food"),
                        Definition(.verb, "to eat"),
                        Definition(.verb, "to drink"),
                        Definition(.verb, "to swallow")]
            case .moli:
                return [Definition(.noun, "death"),
                        Definition(.adjective, "dead"),
                        Definition(.adjective, "dying"),
                        Definition(.verb, "to kill")]
            case .monsi:
                return [Definition(.noun, "back"),
                        Definition(.noun, "behind"),
                        Definition(.noun, "rear"),
                        Definition(.noun, "butt"),
                        Definition(.adjective, "back"),
                        Definition(.adjective, "rear")]
            case .monsuta:
                return [Definition(.noun, "fear"),
                        Definition(.noun, "monster"),
                        Definition(.adjective, "scary"),
                        Definition(.adjective, "monstrous"),
                        Definition(.verb, "to scare"),
                        Definition(.verb, "to be afraid of")]
            case .mu:
                return [Definition(.interjection, "any animal sound")]
            case .mun:
                return [Definition(.noun, "moon"),
                        Definition(.noun, "star"),
                        Definition(.noun, "night sky object"),
                        Definition(.adjective, "lunar"),
                        Definition(.adjective, "stellar")]
            case .musi:
                return [Definition(.noun, "game"),
                        Definition(.noun, "art"),
                        Definition(.adjective, "entertaining"),
                        Definition(.adjective, "artistic"),
                        Definition(.adjective, "amusing"),
                        Definition(.verb, "to amuse"),
                        Definition(.verb, "to play"),
                        Definition(.verb, "to have fun")]
            case .mute:
                return [Definition(.noun, "quantity"),
                        Definition(.adjective, "many"),
                        Definition(.adjective, "more"),
                        Definition(.number, "3 or more"),
                        Definition(.number, "20")]
            case .n:
                return [Definition(.interjection, "um..., hm...")]
            case .namako:
                return [Definition(.noun, "spice"),
                        Definition(.noun, "addition"),
                        Definition(.adjective, "additional"),
                        Definition(.adjective, "extra"),
                        Definition(.verb, "to add"),
                        Definition(.verb, "to spice up")]
            case .nanpa:
                return [Definition(.noun, "number"),
                        Definition(.adjective, "-th (ordinal indicator)"),
                        Definition(.adjective, "mathematical"),
                        Definition(.adjective, "numeric")]
            case .nasa:
                return [Definition(.adjective, "weird"),
                        Definition(.adjective, "unusual"),
                        Definition(.adjective, "strange"),
                        Definition(.adjective, "drunk")]
            case .nasin:
                return [Definition(.noun, "path"),
                        Definition(.noun, "road"),
                        Definition(.noun, "street"),
                        Definition(.noun, "directive"),
                        Definition(.noun, "way"),
                        Definition(.noun, "custom"),
                        Definition(.adjective, "of the way/custom"),
                        Definition(.verb, "to guide"),
                        Definition(.verb, "to show the path")]
            case .nena:
                return [Definition(.noun, "hill"),
                        Definition(.noun, "mountain"),
                        Definition(.noun, "button"),
                        Definition(.noun, "bump"),
                        Definition(.noun, "nose"),
                        Definition(.adjective, "hilly"),
                        Definition(.adjective, "mountainous"),
                        Definition(.adjective, "bumpy")]
            case .ni:
                return [Definition(.noun, "this"),
                        Definition(.noun, "that"),
                        Definition(.adjective, "this"),
                        Definition(.adjective, "that")]
            case .nimi:
                return [Definition(.noun, "word"),
                        Definition(.noun, "name")]
            case .noka:
                return [Definition(.noun, "foot"),
                        Definition(.noun, "leg"),
                        Definition(.noun, "bottom"),
                        Definition(.noun, "lower part"),
                        Definition(.noun, "under")]
            case .o:
                return [Definition(.particle, "addressing people"),
                        Definition(.particle, "commands")]
            case .oko:
                return [Definition(.noun, "eye")]
            case .olin:
                return [Definition(.noun, "love"),
                        Definition(.noun, "compassion"),
                        Definition(.noun, "affection"),
                        Definition(.noun, "respect"),
                        Definition(.adjective, "loved"),
                        Definition(.adjective, "favorite"),
                        Definition(.adjective, "respected"),
                        Definition(.verb, "to love"),
                        Definition(.verb, "to respect")]
            case .ona:
                return [Definition(.noun, "he, she, they, it"),
                        Definition(.adjective, "his, her, their, its")]
            case .open:
                return [Definition(.noun, "start"),
                        Definition(.noun, "beginning"),
                        Definition(.adjective, "initial"),
                        Definition(.adjective, "starting"),
                        Definition(.verb, "to start"),
                        Definition(.verb, "to open"),
                        Definition(.verb, "to turn on"),
                        Definition(.preverb, "to begin doing something")]
            case .pakala:
                return [Definition(.noun, "damage"),
                        Definition(.noun, "mistake"),
                        Definition(.adjective, "broken"),
                        Definition(.adjective, "wrong"),
                        Definition(.verb, "to break"),
                        Definition(.verb, "to make mistakes"),
                        Definition(.particle, "generic curse")]
            case .pali:
                return [Definition(.noun, "work"),
                        Definition(.noun, "labor"),
                        Definition(.adjective, "working"),
                        Definition(.verb, "to work on"),
                        Definition(.verb, "to make")]
            case .palisa:
                return [Definition(.noun, "long solid object"),
                        Definition(.noun, "branch"),
                        Definition(.noun, "stick"),
                        Definition(.adjective, "long")]
            case .pan:
                return [Definition(.noun, "bread"),
                        Definition(.noun, "grain"),
                        Definition(.noun, "corn"),
                        Definition(.noun, "rice"),
                        Definition(.noun, "pizza")]
            case .pana:
                return [Definition(.adjective, "given", isDeprecated: true),
                        Definition(.adjective, "sent", isDeprecated: true),
                        Definition(.adjective, "released", isDeprecated: true),
                        Definition(.verb, "to give"),
                        Definition(.verb, "to send"),
                        Definition(.verb, "to emit"),
                        Definition(.verb, "to release")]
            case .pi:
                return [Definition(.particle, "of (regroups two or more modifiers)")]
            case .pilin:
                return [Definition(.noun, "heart"),
                        Definition(.noun, "feeling"),
                        Definition(.noun, "touch"),
                        Definition(.noun, "sense"),
                        Definition(.adjective, "feeling"),
                        Definition(.adjective, "touch-based"),
                        Definition(.verb, "to touch"),
                        Definition(.verb, "to think"),
                        Definition(.verb, "to feel")]
            case .pimeja:
                return [Definition(.noun, "the color black"),
                        Definition(.noun, "shadow"),
                        Definition(.adjective, "black"),
                        Definition(.adjective, "dark"),
                        Definition(.verb, "to color something black"),
                        Definition(.verb, "to cast a shadow")]
            case .pini:
                return [Definition(.noun, "end"),
                        Definition(.noun, "finish"),
                        Definition(.adjective, "final"),
                        Definition(.adjective, "completed"),
                        Definition(.adjective, "finished"),
                        Definition(.adjective, "past"),
                        Definition(.verb, "to end"),
                        Definition(.verb, "to finish"),
                        Definition(.verb, "to close"),
                        Definition(.preverb, "to stop doing something")]
            case .pipi:
                return [Definition(.noun, "insect"),
                        Definition(.noun, "bug")]
            case .poka:
                return [Definition(.noun, "hip"),
                        Definition(.noun, "side"),
                        Definition(.noun, "nearby area"),
                        Definition(.adjective, "neighboring"),
                        Definition(.adjective, "nearby"),
                        Definition(.adjective, "at one's side")]
            case .poki:
                return [Definition(.noun, "box"),
                        Definition(.noun, "container"),
                        Definition(.noun, "bowl"),
                        Definition(.noun, "cup"),
                        Definition(.noun, "drawer"),
                        Definition(.verb, "to put in a box", isDeprecated: true)]
            case .pona:
                return [Definition(.noun, "good"),
                        Definition(.noun, "simplicity"),
                        Definition(.adjective, "good"),
                        Definition(.adjective, "simple"),
                        Definition(.adjective, "friendly"),
                        Definition(.adjective, "peaceful"),
                        Definition(.verb, "to improve"),
                        Definition(.verb, "to fix")]
            case .pu:
                return [Definition(.noun, "the official toki pona book"),
                        Definition(.adjective, "as told in the official toki pona book"),
                        Definition(.verb, "interacting with the official toki pona book")]
            case .sama:
                return [Definition(.noun, "similarity"),
                        Definition(.noun, "sibling"),
                        Definition(.adjective, "similar"),
                        Definition(.adjective, "like"),
                        Definition(.preposition, "as"),
                        Definition(.preposition, "like")]
            case .seli:
                return [Definition(.noun, "heat"),
                        Definition(.noun, "warmth"),
                        Definition(.noun, "chemical reaction"),
                        Definition(.noun, "heat source"),
                        Definition(.adjective, "warm"),
                        Definition(.adjective, "hot"),
                        Definition(.verb, "to heat")]
            case .selo:
                return [Definition(.noun, "outer form"),
                        Definition(.noun, "outer layer"),
                        Definition(.noun, "shell"),
                        Definition(.noun, "skin"),
                        Definition(.noun, "boundary"),
                        Definition(.adjective, "outer")]
            case .seme:
                return [Definition(.particle, "what? which? (for questions)")]
            case .sewi:
                return [Definition(.noun, "area above"),
                        Definition(.noun, "top"),
                        Definition(.noun, "highest part"),
                        Definition(.noun, "sky"),
                        Definition(.noun, "god"),
                        Definition(.adjective, "high"),
                        Definition(.adjective, "above"),
                        Definition(.adjective, "divine"),
                        Definition(.adjective, "sacred")]
            case .sijelo:
                return [Definition(.noun, "body"),
                        Definition(.noun, "physical state"),
                        Definition(.noun, "torso"),
                        Definition(.adjective, "physical"),
                        Definition(.adjective, "of the body")]
            case .sike:
                return [Definition(.noun, "circle"),
                        Definition(.noun, "ball"),
                        Definition(.noun, "cycle"),
                        Definition(.noun, "wheel"),
                        Definition(.noun, "year"),
                        Definition(.adjective, "round"),
                        Definition(.adjective, "circular"),
                        Definition(.adjective, "spherical"),
                        Definition(.adjective, "of one year"),
                        Definition(.verb, "to make a circle around"),
                        Definition(.verb, "to surround")]
            case .sin:
                return [Definition(.noun, "novelty"),
                        Definition(.noun, "addition"),
                        Definition(.adjective, "new"),
                        Definition(.adjective, "additional"),
                        Definition(.adjective, "fresh"),
                        Definition(.adjective, "extra"),
                        Definition(.verb, "to add"),
                        Definition(.verb, "to update")]
            case .sina:
                return [Definition(.noun, "you"),
                        Definition(.adjective, "your")]
            case .sinpin:
                return [Definition(.noun, "face"),
                        Definition(.noun, "foremost part"),
                        Definition(.noun, "front"),
                        Definition(.noun, "wall"),
                        Definition(.adjective, "of face"),
                        Definition(.adjective, "foremost")]
            case .sitelen:
                return [Definition(.noun, "symbol"),
                        Definition(.noun, "image"),
                        Definition(.noun, "writing"),
                        Definition(.adjective, "symbolic"),
                        Definition(.adjective, "written"),
                        Definition(.adjective, "recorded"),
                        Definition(.verb, "to write"),
                        Definition(.verb, "to draw"),
                        Definition(.verb, "to record")]
            case .soko:
                return [Definition(.noun, "mushroom"),
                        Definition(.noun, "fungus")]
            case .sona:
                return [Definition(.noun, "knowledge"),
                        Definition(.noun, "information"),
                        Definition(.adjective, "known"),
                        Definition(.verb, "to know"),
                        Definition(.preverb, "to know how to do something")]
            case .soweli:
                return [Definition(.noun, "land mammal"),
                        Definition(.noun, "animal")]
            case .suli:
                return [Definition(.noun, "size"),
                        Definition(.noun, "greatness"),
                        Definition(.adjective, "big"),
                        Definition(.adjective, "heavy"),
                        Definition(.adjective, "tall"),
                        Definition(.adjective, "great"),
                        Definition(.adjective, "important"),
                        Definition(.adjective, "adult"),
                        Definition(.verb, "to grow")]
            case .suno:
                return [Definition(.noun, "sun"),
                        Definition(.noun, "light"),
                        Definition(.noun, "brightness"),
                        Definition(.noun, "light source"),
                        Definition(.adjective, "solar"),
                        Definition(.adjective, "bright"),
                        Definition(.verb, "to light"),
                        Definition(.verb, "to shine")]
            case .supa:
                return [Definition(.noun, "horizontal surface")]
            case .suwi:
                return [Definition(.noun, "sweets", isDeprecated: true),
                        Definition(.noun, "fragrances", isDeprecated: true),
                        Definition(.adjective, "sweet"),
                        Definition(.adjective, "fragrant"),
                        Definition(.adjective, "cute"),
                        Definition(.adjective, "adorable")]
            case .tan:
                return [Definition(.noun, "cause"),
                        Definition(.noun, "reason"),
                        Definition(.noun, "origin"),
                        Definition(.adjective, "original"),
                        Definition(.verb, "to cause", isDeprecated: true),
                        Definition(.preposition, "from"),
                        Definition(.preposition, "because of")]
            case .taso:
                return [Definition(.particle, "but"),
                        Definition(.particle, "however"),
                        Definition(.adjective, "only")]
            case .tawa:
                return [Definition(.noun, "movement"),
                        Definition(.adjective, "moving"),
                        Definition(.verb, "to move"),
                        Definition(.preposition, "to"),
                        Definition(.preposition, "for"),
                        Definition(.preposition, "from the perspective of")]
            case .telo:
                return [Definition(.noun, "water"),
                        Definition(.noun, "fluid"),
                        Definition(.noun, "liquid"),
                        Definition(.adjective, "wet"),
                        Definition(.adjective, "fluid"),
                        Definition(.adjective, "liquid"),
                        Definition(.verb, "to water"),
                        Definition(.verb, "to clean")]
            case .tenpo:
                return [Definition(.noun, "time"),
                        Definition(.noun, "moment"),
                        Definition(.noun, "occasion"),
                        Definition(.adjective, "temporal")]
            case .toki:
                return [Definition(.noun, "speech"),
                        Definition(.noun, "conversation"),
                        Definition(.noun, "language"),
                        Definition(.adjective, "verbal"),
                        Definition(.adjective, "conversational"),
                        Definition(.verb, "to speak"),
                        Definition(.verb, "to talk"),
                        Definition(.verb, "to use language"),
                        Definition(.verb, "to think")]
            case .tomo:
                return [Definition(.noun, "home"),
                        Definition(.noun, "building"),
                        Definition(.noun, "structure"),
                        Definition(.noun, "indoor space"),
                        Definition(.noun, "room"),
                        Definition(.adjective, "indoor")]
            case .tonsi:
                return [Definition(.noun, "non-binary person"),
                        Definition(.noun, "trans person"),
                        Definition(.adjective, "gender-nonconforming"),
                        Definition(.adjective, "trans")]
            case .tu:
                return [Definition(.number, "2"),
                        Definition(.noun, "divide"),
                        Definition(.adjective, "divided"),
                        Definition(.verb, "to divide")]
            case .unpa:
                return [Definition(.noun, "sex"),
                        Definition(.adjective, "sexual"),
                        Definition(.verb, "to have sex with")]
            case .uta:
                return [Definition(.noun, "mouth"),
                        Definition(.noun, "lips"),
                        Definition(.adjective, "oral")]
            case .utala:
                return [Definition(.noun, "fight"),
                        Definition(.noun, "battle"),
                        Definition(.noun, "challenge"),
                        Definition(.noun, "war"),
                        Definition(.adjective, "aggressive"),
                        Definition(.adjective, "warlike"),
                        Definition(.verb, "to fight"),
                        Definition(.verb, "to battle"),
                        Definition(.verb, "to challenge")]
            case .walo:
                return [Definition(.noun, "the color white"),
                        Definition(.adjective, "white"),
                        Definition(.adjective, "bright"),
                        Definition(.verb, "to color something white")]
            case .wan:
                return [Definition(.number, "1"),
                        Definition(.noun, "part"),
                        Definition(.adjective, "united"),
                        Definition(.adjective, "married"),
                        Definition(.verb, "to unite"),
                        Definition(.verb, "to marry")]
            case .waso:
                return [Definition(.noun, "bird"),
                        Definition(.noun, "flying creature")]
            case .wawa:
                return [Definition(.noun, "strength"),
                        Definition(.noun, "power"),
                        Definition(.noun, "energy"),
                        Definition(.adjective, "strong"),
                        Definition(.adjective, "powerful"),
                        Definition(.adjective, "energetic")]
            case .weka:
                return [Definition(.noun, "absence"),
                        Definition(.noun, "remoteness"),
                        Definition(.adjective, "absent"),
                        Definition(.adjective, "away"),
                        Definition(.adjective, "remote"),
                        Definition(.verb, "to remove"),
                        Definition(.verb, "to get rid of")]
            case .wile:
                return [Definition(.noun, "want"),
                        Definition(.noun, "need"),
                        Definition(.noun, "desire"),
                        Definition(.adjective, "desired"),
                        Definition(.adjective, "needed"),
                        Definition(.adjective, "required"),
                        Definition(.verb, "to want"),
                        Definition(.preverb, "to want to do something")]

            }
        }
        
        /// A collection of every part of speech for this word, gathered from its definitions.
        public var partsOfSpeech:[PartsOfSpeech] {
            Set<PartsOfSpeech>(self.definitions.map({$0.partOfSpeech})).reversed().reversed()
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
        case e
        case en
        case epiku
        case esun
        case ijo
        case ike
        case ilo
        case insa
        case jaki
        case jan
        case jasima
        case jelo
        case jo
        case kala
        case kalama
        case kama
        case kasi
        case ken
        case kepeken
        case kijetesantakalu
        case kili
        case kin
        case kipisi
        case kiwen
        case ko
        case kokosila
        case kon
        case ku
        case kule
        case kulupu
        case kute
        case la
        case lanpan
        case lape
        case laso
        case lawa
        case leko
        case len
        case lete
        case li
        case lili
        case linja
        case lipu
        case loje
        case lon
        case luka
        case lukin
        case lupa
        case ma
        case mama
        case mani
        case meli
        case meso
        case mi
        case mije
        case misikeke
        case moku
        case moli
        case monsi
        case monsuta
        case mu
        case mun
        case musi
        case mute
        case n
        case namako
        case nanpa
        case nasa
        case nasin
        case nena
        case ni
        case nimi
        case noka
        case o
        case oko
        case olin
        case ona
        case open
        case pakala
        case pali
        case palisa
        case pan
        case pana
        case pi
        case pilin
        case pimeja
        case pini
        case pipi
        case poka
        case poki
        case pona
        case pu
        case sama
        case seli
        case selo
        case seme
        case sewi
        case sijelo
        case sike
        case sin
        case sina
        case sinpin
        case sitelen
        case soko
        case sona
        case soweli
        case suli
        case suno
        case supa
        case suwi
        case tan
        case taso
        case tawa
        case telo
        case tenpo
        case toki
        case tomo
        case tonsi
        case tu
        case unpa
        case uta
        case utala
        case walo
        case wan
        case waso
        case wawa
        case weka
        case wile
        
    }
    
    
}
