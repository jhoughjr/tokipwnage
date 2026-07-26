//
//  TokipwnageTests.swift
//  TokipwnageTests
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import XCTest
@testable import Tokipwnage

final class VocabularyTests: XCTestCase {

    // Canonical order for `Vocabulary.Words.PartsOfSpeech`, mirrored here from
    // `Toki.swift`'s private `partsOfSpeechOrder` so the test independently
    // verifies the contract rather than re-reading the implementation's constant.
    private let canonicalPartsOfSpeechOrder: [Vocabulary.Words.PartsOfSpeech] = [
        .noun, .verb, .preverb, .preposition, .particle, .adjective, .number, .interjection
    ]

    // MARK: - 1. Every word has at least one definition

    func testAllWordsHaveAtLeastOneDefinition() {
        for word in Vocabulary.Words.allCases {
            XCTAssertFalse(
                word.definitions.isEmpty,
                "Word \(word.rawValue) should have at least one definition"
            )
        }
    }

    // MARK: - 2. partsOfSpeech is deduplicated and in canonical order

    func testPartsOfSpeechAreDeduplicatedAndOrdered() {
        for word in Vocabulary.Words.allCases {
            let parts = word.partsOfSpeech

            // No duplicates.
            XCTAssertEqual(
                Set(parts).count, parts.count,
                "partsOfSpeech for \(word.rawValue) should contain no duplicates, got \(parts)"
            )

            // Equals canonical order filtered down to the parts present for this word.
            let expected = canonicalPartsOfSpeechOrder.filter { Set(parts).contains($0) }
            XCTAssertEqual(
                parts, expected,
                "partsOfSpeech for \(word.rawValue) should follow canonical order, got \(parts)"
            )
        }
    }

    // MARK: - 3. partsOfSpeech matches the set of parts across definitions

    func testPartsOfSpeechMatchesDefinitions() {
        for word in Vocabulary.Words.allCases {
            let fromPartsOfSpeech = Set(word.partsOfSpeech)
            let fromDefinitions = Set(word.definitions.map { $0.partOfSpeech })
            XCTAssertEqual(
                fromPartsOfSpeech, fromDefinitions,
                "partsOfSpeech for \(word.rawValue) should match the set of parts of speech across its definitions"
            )
        }
    }

    // MARK: - 4. words(forEnglish:) with empty/whitespace input

    func testWordsForEnglishEmptyReturnsEmpty() {
        XCTAssertEqual(Vocabulary.Words.words(forEnglish: ""), [])
        XCTAssertEqual(Vocabulary.Words.words(forEnglish: "   "), [])
    }

    // MARK: - 5. words(forEnglish:) is case-insensitive
    //
    // "reptile" is verified (Toki.swift) to appear exactly once in the whole
    // vocabulary, as a noun definition of `.akesi` ("lizard" / "reptile" / ...).

    func testWordsForEnglishIsCaseInsensitive() {
        let lower = Vocabulary.Words.words(forEnglish: "reptile")
        let upper = Vocabulary.Words.words(forEnglish: "REPTILE")
        let mixed = Vocabulary.Words.words(forEnglish: "RepTile")
        XCTAssertEqual(lower, upper)
        XCTAssertEqual(lower, mixed)
        XCTAssertEqual(lower, [.akesi])
    }

    // MARK: - 6. Results are sorted ascending by rawValue and deduped
    //
    // "person" is verified (Toki.swift) to appear as a whole-word token in exactly
    // two words' definitions: `.jan` ("person") and `.tonsi` ("non-binary person",
    // "trans person"). "jan" < "tonsi" alphabetically.

    func testWordsForEnglishResultsAreSortedAndDeduped() {
        let results = Vocabulary.Words.words(forEnglish: "person")
        XCTAssertEqual(results, [.jan, .tonsi])
        XCTAssertEqual(Set(results).count, results.count, "results should contain no duplicates")
        XCTAssertEqual(results, results.sorted { $0.rawValue < $1.rawValue })
    }

    // MARK: - 7. A specific known English -> toki pona mapping
    //
    // "reptile" -> .akesi, verified directly against Toki.swift's definitions for `.akesi`.

    func testWordsForEnglishFindsKnownWord() {
        let results = Vocabulary.Words.words(forEnglish: "reptile")
        XCTAssertTrue(results.contains(.akesi), "expected .akesi among results for 'reptile', got \(results)")
    }

    // MARK: - 8. Whole-word matching contract
    //
    // Rather than relying on a hand-picked substring example (fragile against data
    // changes), verify the contract directly against real results: every word
    // returned for a query must contain that query as a whole-word token (split on
    // non-letter characters, case-insensitively) in at least one of its meanings —
    // not merely as a substring of a longer word (e.g. "person" inside "personal").

    func testWordsForEnglishWholeWordNotSubstring() {
        let query = "person"
        let results = Vocabulary.Words.words(forEnglish: query)
        XCTAssertFalse(results.isEmpty, "expected at least one match for '\(query)'")

        for word in results {
            let hasWholeWordMatch = word.definitions.contains { definition in
                let tokens = definition.meaning
                    .lowercased()
                    .split(whereSeparator: { !$0.isLetter })
                    .map(String.init)
                return tokens.contains(query)
            }
            XCTAssertTrue(
                hasWholeWordMatch,
                "\(word.rawValue) matched query '\(query)' but has no definition containing it as a whole word"
            )
        }

        // Sanity check on the specific known data: querying "personal" (a word that
        // contains "person" as a substring) must NOT be conflated with "person" —
        // .jan matches both queries (it has separate "person" and "personal"
        // definitions), but the two queries are independently indexed.
        let personalResults = Vocabulary.Words.words(forEnglish: "personal")
        XCTAssertEqual(personalResults, [.jan])
        for word in personalResults {
            let hasWholeWordMatch = word.definitions.contains { definition in
                let tokens = definition.meaning
                    .lowercased()
                    .split(whereSeparator: { !$0.isLetter })
                    .map(String.init)
                return tokens.contains("personal")
            }
            XCTAssertTrue(hasWholeWordMatch)
        }
    }
}
