//
//  ContentView.swift
//  Set
//
//  Created by Kim Woonha on 27/7/21.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        SetView(viewModel: game)
    }
}
