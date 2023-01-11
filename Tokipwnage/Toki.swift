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
            }
        }
        
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
        
        /*
         
         jasima (nimi ku suli)

         noun: mirror, reflection, echo
         adjective: opposite
         verb: to reflect, to reverse
         
         jelo

         noun/adjective: (the color) yellow (and its shades)
         verb: to color smth yellow
         jo

         noun: (unconventional) possessions, property
         verb: to have/carry/contain/hold
         kala

         noun: fish, marine animal, sea creature
         kalama

         noun: sound, noise
         adjective: loud, noisy, sound-making
         verb: to make noise, to recite, to play (an instrument)
         kama

         noun: event, arrival
         adjective: arriving, coming, future, summoned
         pre-verb: to become, to be in the process of (doing smth), to manage to, to succeed in
         kasi

         noun: plant, grass, herb, leaf
         ken

         noun: ability, possibility, (unconventional) right, liberty
         adjective (unconventional): able, possible
         pre-verb: can (do smth), may (do smth)
         kepeken

         noun: use, (unconventional) practice
         verb w/ obj: to use smth
         preposition: (do smth) using, with the help of
         kijetesantakalu (nimi ku suli)

         noun: raccoon or other musteloid
         This is one of the “joke words” created by Sonja Lang. It has become very popular among tokiponists, as has the sitelen pona character for it.

         kili

         noun: fruit, vegetable, mushroom
         kin (nimi ku suli)

         particle: very, really, also
         In the first official book, this word was merged with “a”. However, many people use it separately from “a”. They would only use “a” to emphasize someone’s feelings.

         kipisi (nimi ku suli)

         verb: to cut, to divide
         This is an old word that was not included in the first official book, but which many people still use. Those who want to only use lipu pu vocabulary might want to use “tu”, which can also be used as a verb to mean “to divide”, the same way “wan” means “to unite”.

         kiwen

         noun: hard object, metal, stone, solid
         adjective: hard, metallic, solid
         ko

         noun: powder, clay, paste, semi-solid
         kokosila (nimi ku suli)

         verb: to speak not in toki pona in an environment where others speak toki pona
         This word is taken from an Esperanto verb “krokodili”, which in turn means to not speak Esperanto in an Esperanto environment.

         kon

         noun: air, essence, spirit, (unconventional) gas
         adjective: invisible, ephemeral, (unconventional) gaseous
         ku (nimi ku suli)

         noun: the Toki Pona Dictionary by Sonja Lang
         verb: to interact with ku
         Much like interacting with the first official toki pona book was given the word “pu”, so does the second book with “ku”. In fact, in lipu ku, words “ju”, “lu”, “nu”, “su” and “u” are all listed as “(word reserved for future use by Sonja Lang)”, presumably to be given to the next five official toki pona books that (in my opinion) should be created in the future.

         kule

         noun: color, (rare) gender
         adjective: colorful, painted
         verb: to paint smth a color
         kulupu

         noun: group, community, company, society, nation, tribe
         adjective: communal, social
         kute

         noun: ear, hearing
         adjective: …-sounding
         verb: to hear, to listen, to obey
         la

         particle: “if/when” (introduces context)
         lanpan (nimi ku suli)

         verb: to get, to take, to steal
         Without this word, the typical way to express getting or taking something would be “kama jo e …” (to come into possession of …), possibly with additional adjectives like “ike” or “utala”. The word is famously used in the title of “lanpan pan”, the toki pona translation/summary of Peter Kropotkin’s “The Conquest of Bread”.

         lape

         noun: sleep, rest
         adjective: sleeping, restful
         verb: to sleep, to rest
         laso

         noun/adjective: (the color) blue, green (and its shades)
         verb: to color something blue/green
         lawa

         noun: head, mind
         adjective: main, primary, controlling, ruling
         verb: to head, to control, to direct, to guide, to lead, to own, to rule
         leko (nimi ku suli)

         noun: square, block, (sometimes) stairs
         This is an old word that was not included in the first official book, but which is actively used by people, as it’s considered hard to express the meaning of “square” without it.

         len

         noun: cloth, clothes, fabric, layer of privacy
         adjective: clothed, made of cloth/fabric
         verb: to clothe, to provide a layer of privacy
         lete

         noun: cold
         adjective: cold, cool, raw, uncooked
         verb: to cool down
         li

         particle: (between subj. and verb/adj.)
         lili

         noun: smallness
         adjective: small, few, young
         verb: to shrink
         linja

         noun: long flexible object, string, rope, hair
         lipu

         noun: flat object, book, document, paper, page, record, website
         adjective: flat, used as lipu, lipu-like, of lipu
         loje

         noun/adjective: (the color) red (and its shades)
         verb: to color smth red
         lon

         noun: truth, life, existence
         adjective: real, true, present, existing
         verb w/o object: is true, exists
         preposition: in, at, on
         luka

         noun: hand, arm
         number: 5 (complex system)
         lukin

         noun: eye, vision
         adjective: …-looking, visual
         verb: to look, to see, to read
         pre-verb: to seek (to do something)
         lupa

         noun: hole, door, orifice, window
         ma

         noun: earth, land, outdoors, territory, country
         mama

         noun: parent, ancestor, creator, origin, caretaker
         verb: to create, to parent, to take care of
         mani

         noun: money, large domesticated animal
         adjective: (unconventional) wealthy
         meli

         noun: woman, female, wife
         adjective: feminine
         meso (nimi ku suli)

         noun: middle, center
         adjective: average, moderate, mediocre
         In some ways, this word is similar to “insa”, but it also lets people say that a thing is moderately X without having to use phrases like “ona li wawa mute ala, li wawa lili ala”.

         mi

         noun: i, me, we, us
         adjective: my, our
         mije

         noun: man, male, husband
         adjective: masculine
         misikeke (nimi ku suli)

         noun: medicine, cure
         adjective: medicinal
         verb: to cure
         This word was invented by Sonja Lang, but was not included as part of lipu pu. (My personal guess is because “ijo pi pona sijelo” is a rather simple way to say “medicine” without it.)

         moku

         noun: food
         adjective: edible, of food
         verb: to eat, to drink, to swallow
         moli

         noun: death
         adjective: dead, dying
         verb: to kill
         monsi

         noun: back, behind, rear, butt
         adjective: back, rear
         monsuta (nimi ku suli)

         noun: fear, monster
         adjective: scary, monstrous
         verb: to scare, to be afraid of, (sometimes) to turn into a monster
         The usage of this word can be especially confusing without extra context. Some people refer to this confusion as “monsutatesu”.

         mu

         (any animal sound)
         mun

         noun: moon, star, night sky object
         adjective: lunar, stellar
         musi

         noun: game, art
         adjective: entertaining, artistic, amusing
         verb: to amuse, to play, to have fun
         mute

         noun: quantity
         adjective: many, more
         number: 3 or more (simple system), 20 (complex system)
         n (nimi ku suli)

         interjection: um…, hm… (“thinking noise”)
         Technically, the word “n” breaks the rules of toki pona by using a non-allowed syllable, but as it basically functions as a word on its own, it’s allowed. Or one can interpret syllable-final “n” as a separate mora, like in Japanese, where “n” on its own is apparently also used as an interjection…

         namako (nimi ku suli)

         noun: spice, addition
         adjective: additional, extra
         verb: to add, to spice up
         In the first official book, this word was merged with “sin”. However, many people keep using it separately from “sin”. “sin” is interpreted to mean “new” and “namako” to mean “additional”.

         nanpa

         noun: number
         adjective: -th (ordinal indicator), mathematical, numeric, (unconventional) digital
         nasa

         adjective: weird, unusual, strange, drunk
         nasin

         noun: path, road, street, directive, way, custom
         adjective: street-, true to the directive/way/custom
         verb (unconventional): to guide, to show the path
         nena

         noun: hill, mountain, button, bump, nose
         adjective: hilly, mountainous, bumpy
         ni

         noun/adjective: this, that
         nimi

         noun: word, name
         noka

         noun: foot, leg, bottom, lower part, under (smth)
         o

         particle: (addressing people, commands)
         oko (nimi ku suli)

         noun: eye
         In the first official book, this word was merged into “lukin”. People who use this word separately from “lukin” typically use “oko” to mean “eye” and “lukin” to mean “sight” or “vision”.

         olin

         noun: love, compassion, affection, respect
         adjective: loved, favorite, respected
         verb: to love, to respect
         ona

         noun: he, she, they, it
         adjective: his, her, their, its
         open

         noun: start, beginning
         adjective: initial, starting
         verb: to start, to open, to turn on
         pre-verb: to begin (doing something)
         pakala

         noun: damage, mistake
         adjective: broken, wrong
         verb: to break, to make mistakes
         particle: (generic curse)
         pali

         noun: work, labor
         adjective: working
         verb: to work (on), to make
         palisa

         noun: long solid object, branch, stick, (unconventional) length
         adjective: long
         pan

         noun: bread, grain, corn, rice, pizza
         pana

         adjective: (unconventional) given, sent, released
         verb: to give, to send, to emit, to release
         pi

         particle: “of” (regroups two or more modifiers)
         pilin

         noun: heart, feeling, touch, sense
         adjective: feeling, touch-based
         verb: to touch, to think, to feel
         pimeja

         noun: (the color) black (and its shades), shadow
         adjective: black, dark
         verb: to color smth black, to cast a shadow
         pini

         noun: end, finish
         adjective: final, completed, finished, past (with tenpo)
         verb: to end, to finish, to close
         pre-verb: to end/stop doing something
         pipi

         noun: insect, bug
         poka

         noun: hip, side, nearby area
         adjective: neighboring, nearby, at one’s side
         poki

         noun: box, container, bowl, cup, drawer
         verb (unconventional): to put in a box
         pona

         noun: good, simplicity
         adjective: good, simple, friendly, peaceful
         verb: to improve, to fix
         pu

         noun: the official toki pona book
         adjective: as told in the official toki pona book
         verb: interacting with the official toki pona book
         The official toki pona book only defines the verb meaning of the word “pu”. (Although the phrase “pu la” is used in it to mean “in this book”.) Some people in the toki pona community prefer to only use it in the verb meaning, while others use it in others as well.

         sama

         noun: similarity, (someone’s) sibling
         adjective: similar, like, sibling
         preposition: as, like
         seli

         noun: heat, warmth, chemical reaction, heat source
         adjective: warm, hot
         verb: to heat
         selo

         noun: outer form, outer layer, shell, skin, boundary
         adjective: outer
         seme

         particle: what? which? (for questions)
         sewi

         noun: area above, top, highest part, sky, god
         adjective: high, above, divine, sacred
         sijelo

         noun: body, physical state, torso
         adjective: physical, of sijelo
         sike

         noun: circle, ball, cycle, wheel, (with tenpo) year
         adjective: round, circular, spherical, of one year
         verb: to make a circle around, to surround
         sin

         noun: novelty, addition, (unconventional) update, spice
         adjective: new, additional, fresh, extra
         verb: to add, to update
         sina

         noun: you
         adjective: your
         sinpin

         noun: face, foremost part, front, wall
         adjective: of face, foremost
         sitelen

         noun: symbol, image, writing
         adjective: symbolic, written, recorded
         verb: to write, to draw, to record
         soko (nimi ku suli)

         noun: mushroom, fungus
         People who want to only use lipu pu vocabulary sometimes also use “kili ma” to refer to mushrooms. Alternatively, “kili pi kasi ala” is also possible, since “kili” also refers to mushrooms.

         sona

         noun: knowledge, information
         adjective: known
         verb: to know
         pre-verb: to know (how to do something)
         soweli

         noun: land mammal, animal
         suli

         noun: size, greatness
         adjective: big, heavy, tall, great, important, adult
         verb: to grow
         suno

         noun: sun, light, brightness, light source
         adjective: solar, bright
         verb: to light, to shine
         supa

         noun: horizontal surface
         suwi

         noun: (unconventional) sweets, fragrances
         adjective: sweet, fragrant, cute, adorable
         tan

         noun: cause, reason, origin
         adjective: original
         verb w/ object (unconventional): to cause
         preposition: from, because of
         taso

         particle (at beginning of sentence): but, however
         adjective: only
         tawa

         noun: movement
         adjective: moving
         verb: to move
         preposition: to, for, from perspective of
         telo

         noun/adjective: water, fluid, liquid
         adjective: wet, fluid, liquid
         verb: to water, to clean
         tenpo

         noun: time, moment, occasion
         adjective: temporal
         toki

         noun: speech, conversation, language
         adjective: verbal, conversational
         verb: to speak, to talk, to use language, to think
         tomo

         noun: home, building, structure, indoor space, room
         adjective: indoor
         tonsi (nimi ku suli)

         noun: non-binary person, trans person
         adjective: gender-nonconforming, trans
         The word “tonsi” was created by the community after the official book was released and, according to a poll in October of 2021, is the most accepted “new” non-official word.

         tu

         number: 2
         noun: divide
         adjective: divided
         verb: to divide
         Using “tu” at the end of a noun phrase is generally associated with the number 2. The meaning “divided” is usually specified by using a “li” particle:

         kulupu tu – two communities

         kulupu li tu. – the community is divided.

         unpa

         noun: sex
         adjective: sexual
         verb: to have sex with
         uta

         noun: mouth, lips
         adjective: oral
         utala

         noun: fight, battle, challenge, war
         adjective: aggressive, warlike
         verb: to fight, to battle, to challenge
         walo

         noun: the color white (and its shades)
         adjective: white, bright/light
         verb: to color something white
         wan

         number: 1
         noun: part (of smth)
         adjective: united, married
         verb: to unite, to marry
         Using “wan” at the end of a noun phrase is generally associated with the number 1. The meaning “united” is usually specified by using a “li” particle:

         kulupu wan – one community

         kulupu li wan. – the community is united.

         kulupu mute wan – 21 communities (complex numbering system)

         kulupu mute li wan – many (or 20) communities are united.

         waso

         noun: bird, flying creature
         wawa

         noun: strength, power, energy
         adjective: strong, powerful, energetic
         weka

         noun: absence, remoteness
         adjective: absent, away, remote
         verb: remove, get rid of
         wile

         noun: want, need, desire
         adjective: desired, needed, required
         verb: to want smth
         pre-verb: to want to do smth

         */
        
    }
    
    
}
