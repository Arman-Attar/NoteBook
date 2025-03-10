//
//  NoteBookApp.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-09.
//

import SwiftUI
import TelemetryDeck

@main
struct NoteBookApp: App {
    
    init() {
        let config = TelemetryDeck.Config(appID: "9FCDAF0B-6B68-4507-98B4-A5C6178A60F3")
        TelemetryDeck.initialize(config: config)
    }
    
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
}
