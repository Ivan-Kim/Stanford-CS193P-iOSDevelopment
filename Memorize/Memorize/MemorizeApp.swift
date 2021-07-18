//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Kim Woonha on 13/7/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
