//
//  TokipwnageApp.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

@main
struct TokipwnageApp: App {
    @StateObject private var speaker = Speaker()
    @StateObject private var prefs = Preferences()
    @StateObject private var favorites = FavoritesStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(speaker)
                .environmentObject(prefs)
                .environmentObject(favorites)
        }
    }
}
