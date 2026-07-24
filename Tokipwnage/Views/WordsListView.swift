//
//  WordsListView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

struct WordListView: View {

    @ObservedObject var provider:WordsProvider
    @State var isShowingPrefs = false
    @State var navigable = true
    @State private var activeFilters: Set<Vocabulary.Words.PartsOfSpeech> = []

    private var displayedWords: [Vocabulary.Words] {
        guard !activeFilters.isEmpty else { return provider.words }
        return provider.words.filter { word in
            !activeFilters.isDisjoint(with: Set(word.partsOfSpeech))
        }
    }

    private var searchSelector: some View {
        HStack(spacing: 6) {
            ForEach(WordsProvider.SearchCategory.allCases, id: \.self) { category in
                let active = provider.category == category
                Button {
                    provider.category = category
                } label: {
                    Text(category.string())
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(active ? Color.accentColor : Color.accentColor.opacity(0.12))
                        )
                        .foregroundColor(active ? .white : .accentColor)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var searchField: some View {
        TextField("Search",
                  text: $provider.searchString,
                  prompt: Text("Search \($provider.category.wrappedValue.string())"))
        .onChange(of: provider.searchString) { newValue in
            provider.loadSearch(s: newValue)
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(Vocabulary.Words.PartsOfSpeech.allCases, id: \.self) { part in
                    let active = activeFilters.contains(part)
                    Button {
                        if active {
                            activeFilters.remove(part)
                        } else {
                            activeFilters.insert(part)
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(active ? Color.white : part.color)
                                .frame(width: 7, height: 7)
                            Text(part.rawValue)
                                .font(.caption2)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(active ? part.color : part.color.opacity(0.12))
                        )
                        .foregroundColor(active ? .white : part.color)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 2)
        }
    }

    private var title: some View {
        HStack {
            Text("Words")
                .font(.title)
            Text("\(displayedWords.count)")
                .fontWeight(.ultraLight)
            Spacer()
            NavigationLink(destination: TranslateView(),
                           label: { Image(systemName: "arrow.left.arrow.right") })
            NavigationLink(destination: PreferencesView(),
                           label: { Image(systemName: "gear") })
        }
    }

    @ViewBuilder
    private func rowContent(for word: Vocabulary.Words) -> some View {
        HStack {
            Text(word.rawValue)
            Spacer()
            HStack(spacing: 4) {
                ForEach(word.partsOfSpeech, id: \.self) { part in
                    Circle()
                        .fill(part.color)
                        .frame(width: 8, height: 8)
                }
            }
        }
    }

    private var list: some View {
        List {
            ForEach(displayedWords, id:\.rawValue) { word in
                if navigable {
                    NavigationLink(destination: WordView(word: word,
                                                        provider: provider)) {
                        rowContent(for: word)
                    }
                } else {
                    rowContent(for: word)
                }
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading,
               content: {
            title
            searchField
            searchSelector
            filterBar
            list
        })
        .padding()
    }
}
