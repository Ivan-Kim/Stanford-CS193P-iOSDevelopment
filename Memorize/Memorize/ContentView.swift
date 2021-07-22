//
//  ContentView.swift
//  Memorize
//
//  Created by Kim Woonha on 13/7/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
        //  Required Task 14. Show the theme’s name in your UI. You can do this in whatever way you think looks best.
            Text("\(viewModel.theme.name)").font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
        //  Required Task 16. Display the score in your UI. You can do this in whatever way you think looks best.
            Text("Score: \(viewModel.score)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.getColor(of: viewModel.theme.color))
            .padding(.horizontal)
        //  Required Task 10. Add a “New Game” button to your UI (anywhere you think is best) which begins a brand new game.
            Button {
            //  Required Task 9. A new theme should be able to be added to your game with a single line of code.
                viewModel.startNewGame()
            } label: {
                Text("New Game")
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
