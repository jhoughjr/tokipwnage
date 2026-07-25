//
//  WordsListView.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

private func selectionHaptic() {
    #if os(iOS)
    UIImpactFeedbackGenerator(style: .light).impactOccurred()
    #endif
}

/// A simple wrapping (flow) layout: lays subviews left-to-right and wraps to a
/// new line when the proposed width is exceeded, so chips display regardless of
/// the container width instead of scrolling or clipping.
struct FlowLayout: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var widest: CGFloat = 0

        for sub in subviews {
            let size = sub.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
            widest = max(widest, x - spacing)
        }
        return CGSize(width: min(widest, maxWidth), height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0

        for sub in subviews {
            let size = sub.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            sub.place(at: CGPoint(x: x, y: y), anchor: .topLeading, proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

struct WordListView: View {

    @ObservedObject var provider:WordsProvider
    @Binding var selection: Vocabulary.Words?
    @EnvironmentObject var favorites: FavoritesStore
    @State var isShowingPrefs = false
    @State private var activeFilters: Set<Vocabulary.Words.PartsOfSpeech> = []
    @State private var searchTask: Task<Void, Never>?
    @State private var showFavoritesOnly = false

    private var displayedWords: [Vocabulary.Words] {
        var words = provider.words
        if !activeFilters.isEmpty {
            words = words.filter { word in
                !activeFilters.isDisjoint(with: Set(word.partsOfSpeech))
            }
        }
        if showFavoritesOnly {
            words = words.filter { favorites.isFavorite($0) }
        }
        return words
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

    private func scheduleSearch(for newValue: String) {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 250_000_000)
            if Task.isCancelled { return }
            await MainActor.run {
                provider.loadSearch(s: newValue)
            }
        }
    }

    private var filterBar: some View {
        FlowLayout(spacing: 6) {
            ForEach(Vocabulary.Words.PartsOfSpeech.allCases, id: \.self) { part in
                let active = activeFilters.contains(part)
                Button {
                    selectionHaptic()
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
                            .accessibilityHidden(true)
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

    private var title: some View {
        HStack {
            Text("Words")
                .font(.title)
            Text("\(displayedWords.count)")
                .fontWeight(.ultraLight)
            Spacer()
            Button {
                showFavoritesOnly.toggle()
            } label: {
                Image(systemName: showFavoritesOnly ? "star.fill" : "star")
                    .foregroundColor(showFavoritesOnly ? .yellow : .primary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Text("Show favorites only"))
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
            if favorites.isFavorite(word) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption2)
                    .accessibilityLabel(Text("favorite"))
            }
            Spacer()
            HStack(spacing: 4) {
                ForEach(word.partsOfSpeech, id: \.self) { part in
                    Circle()
                        .fill(part.color)
                        .frame(width: 8, height: 8)
                        .accessibilityLabel(Text(part.rawValue))
                }
            }
        }
    }

    private var isFiltering: Bool {
        !provider.searchString.isEmpty || !activeFilters.isEmpty || showFavoritesOnly
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text("No words found")
                .font(.headline)
            Text("Try a different search or filter")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }

    private var list: some View {
        List(selection: $selection) {
            ForEach(displayedWords, id: \.rawValue) { word in
                rowContent(for: word).tag(word)
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading,
               content: {
            title
            searchSelector
            filterBar
            if displayedWords.isEmpty && isFiltering {
                emptyState
            } else {
                list
            }
        })
        .padding()
        .searchable(text: $provider.searchString,
                    prompt: Text("Search \(provider.category.string())"))
        .onChange(of: provider.searchString) { newValue in
            scheduleSearch(for: newValue)
        }
        .onChange(of: provider.category) { _ in
            provider.loadSearch(s: provider.searchString)
        }
    }
}
