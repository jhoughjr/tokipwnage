//
//  Preferences.swift
//  Tokipwnage
//
//  Created by Jimmy Hough Jr on 1/11/23.
//

import SwiftUI

class Preferences:ObservableObject {
    /// Stores the user selected voice identifier as a string in App Storage.
    @AppStorage("selected_voice") var selectedVoice = ""
    /// Selects whether a word is spoken upon selection or not.
    @AppStorage("autoSpeak") var autoSpeak = true
}

