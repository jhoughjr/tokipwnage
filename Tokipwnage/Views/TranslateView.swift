//
//  TranslateView.swift
//  Tokipwnage
//

import SwiftUI

struct WordSlot: Identifiable {
    let id = UUID()
    let englishWord: String
    let matchingWords: [Vocabulary.Words]
    var selectedRawValue: String

    var selectedWord: Vocabulary.Words? {
        Vocabulary.Words(rawValue: selectedRawValue)
    }

    private static let stopWords: Set<String> = [
        "the", "a", "an", "is", "are", "was", "were", "be", "been", "being",
        "have", "has", "had", "do", "does", "did", "will", "would", "could",
        "should", "may", "might", "shall", "must", "can", "of", "in", "at",
        "by", "or", "and", "but", "if", "as", "so", "yet", "nor", "for", "its"
    ]

    static func slots(for sentence: String) -> [WordSlot] {
        sentence
            .components(separatedBy: .whitespaces)
            .map { $0.trimmingCharacters(in: .punctuationCharacters).lowercased() }
            .filter { !$0.isEmpty && !stopWords.contains($0) }
            .map { english in
                let matches = Vocabulary.Words.words(forEnglish: english)

                return WordSlot(
                    englishWord: english,
                    matchingWords: matches,
                    selectedRawValue: matches.first?.rawValue ?? ""
                )
            }
    }
}

struct TranslateView: View {

    enum Mode {
        case englishToToki
        case tokiToEnglish
    }

    @State private var mode: Mode = .englishToToki
    @EnvironmentObject private var speaker: Speaker

    // EN → TP
    @State private var englishSentence = ""
    @State private var wordSlots: [WordSlot] = []
    @State private var showVoiceAlert = false

    // TP → EN
    @State private var tokiSearch = ""
    @State private var selectedTokiWords: [Vocabulary.Words] = []

    private var builtPhrase: [Vocabulary.Words] {
        wordSlots.compactMap { $0.selectedWord }
    }

    private func translate() {
        wordSlots = WordSlot.slots(for: englishSentence)
    }

    // MARK: - Shared

    private var modeSelector: some View {
        HStack(spacing: 6) {
            ForEach([(Mode.englishToToki, "EN → TP"), (Mode.tokiToEnglish, "TP → EN")],
                    id: \.1) { (m, label) in
                let active = mode == m
                Button(label) { mode = m }
                    .buttonStyle(.plain)
                    .font(.caption2)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(active ? Color.accentColor : Color.accentColor.opacity(0.12)))
                    .foregroundColor(active ? .white : .accentColor)
            }
        }
    }

    // MARK: - EN → TP

    private var phraseBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(builtPhrase, id: \.rawValue) { word in
                    Text(word.rawValue)
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Capsule().strokeBorder(Color.secondary.opacity(0.4)))
                }
            }
        }
    }

    @ViewBuilder
    private func slotRow(index: Int) -> some View {
        let slot = wordSlots[index]
        HStack(alignment: .center, spacing: 12) {
            Text(slot.englishWord)
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(width: 70, alignment: .trailing)

            if slot.matchingWords.isEmpty {
                Text("no match")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .italic()
            } else {
                if let selected = slot.selectedWord {
                    HStack(spacing: 3) {
                        ForEach(selected.partsOfSpeech, id: \.self) { part in
                            Circle()
                                .fill(part.color)
                                .frame(width: 6, height: 6)
                        }
                    }
                    .frame(width: 44)
                } else {
                    Spacer().frame(width: 44)
                }

                Picker("", selection: Binding(
                    get: { wordSlots[index].selectedRawValue },
                    set: { wordSlots[index].selectedRawValue = $0 }
                )) {
                    Text("—").tag("")
                    ForEach(slot.matchingWords, id: \.rawValue) { word in
                        Text(word.rawValue).tag(word.rawValue)
                    }
                }
                #if os(iOS)
                .pickerStyle(.wheel)
                .frame(height: 80)
                .clipped()
                #else
                .pickerStyle(.menu)
                #endif
            }
        }
        .padding(.vertical, 2)
    }

    @ViewBuilder
    private var speakControl: some View {
        if speaker.isSpeaking {
            Button {
                speaker.stop()
            } label: {
                Image(systemName: "stop.fill")
            }
            .buttonStyle(.plain)
        } else {
            Button {
                if speaker.prefs.selectedVoice.isEmpty {
                    showVoiceAlert = true
                } else {
                    speaker.speak(builtPhrase.map(\.rawValue).joined(separator: " "))
                }
            } label: {
                Image(systemName: "speaker.wave.3")
            }
            .buttonStyle(.plain)
            .disabled(builtPhrase.isEmpty)
        }
    }

    private var englishToTokiView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                TextField("Type an English sentence", text: $englishSentence)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { translate() }
                Button("Go") { translate() }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                speakControl
            }

            if !wordSlots.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("toki pona:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    phraseBar
                }
                .padding(.vertical, 4)

                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(wordSlots.indices, id: \.self) { i in
                            slotRow(index: i)
                        }
                    }
                    .padding(.vertical, 4)
                }
            } else if !englishSentence.isEmpty {
                Text("Press Go to translate")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }

            Spacer()
        }
        .alert("No Voice Selected", isPresented: $showVoiceAlert) {
            Button("OK") {}
        } message: {
            Text("Select a voice in Settings to enable speech.")
        }
    }

    // MARK: - TP → EN

    private var selectedWordsBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(selectedTokiWords, id: \.rawValue) { word in
                    HStack(spacing: 4) {
                        Text(word.rawValue).bold()
                        Button {
                            selectedTokiWords.removeAll { $0 == word }
                        } label: {
                            Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Capsule().strokeBorder(Color.secondary.opacity(0.4)))
                }
                if !selectedTokiWords.isEmpty {
                    Button("clear") { selectedTokiWords = [] }
                        .buttonStyle(.plain)
                        .font(.caption2)
                        .foregroundColor(.red)
                }
            }
        }
    }

    private var meaningsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(selectedTokiWords, id: \.rawValue) { word in
                VStack(alignment: .leading, spacing: 2) {
                    Text(word.rawValue).bold()
                    Text(word.definitions.map { $0.meaning }.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    private var filteredTokiWords: [Vocabulary.Words] {
        guard !tokiSearch.isEmpty else { return Array(Vocabulary.Words.allCases) }
        return Vocabulary.Words.allCases.filter {
            $0.rawValue.localizedCaseInsensitiveContains(tokiSearch)
        }
    }

    private var tokiToEnglishView: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !selectedTokiWords.isEmpty {
                selectedWordsBar
                meaningsSection
                Divider()
            }

            TextField("Search toki pona word", text: $tokiSearch)
                .textFieldStyle(.roundedBorder)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 8) {
                    ForEach(filteredTokiWords, id: \.rawValue) { word in
                        let selected = selectedTokiWords.contains(word)
                        Button {
                            if selected { selectedTokiWords.removeAll { $0 == word } }
                            else { selectedTokiWords.append(word) }
                        } label: {
                            Text(word.rawValue)
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(selected ? Color.accentColor : Color.accentColor.opacity(0.1))
                                )
                                .foregroundColor(selected ? .white : .primary)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            modeSelector
            if mode == .englishToToki {
                englishToTokiView
            } else {
                tokiToEnglishView
            }
        }
        .padding()
        .navigationTitle("Translate")
    }
}
