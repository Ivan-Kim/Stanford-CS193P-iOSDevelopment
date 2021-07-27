//
//  SetApp.swift
//  Set
//
//  Created by Kim Woonha on 27/7/21.
//

import SwiftUI

@main
struct SetApp: App {
    let game = SetViewModel()
    var body: some Scene {
        WindowGroup {
            SetView(viewModel: game)
        }
    }
}
