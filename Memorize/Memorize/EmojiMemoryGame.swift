//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kim Woonha on 17/7/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    //  Hint 13. It’s quite likely that you will need to add an init() to your ViewModel. That’s because you’ll probably have one var whose initialization depends on another var. You can resolve this kind of catch-22 in an init() because, in an init(), you can control the order in which vars get initialized (whereas, when you use property initializers to initialize vars, the order is undetermined, which is why property initializers are not allowed to reference other vars).
    
    init() {
    //  Hint 9. You might find Array’s randomElement() function useful in this assignment (though note that this function (understandably) returns an Optional, so be prepared for that!). This is just a Hint, not a Required Task.
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(in: theme)
    }
    
    //  Hint 14. The code in your ViewModel’s init() might look very, very similar to the code involved with your new game mechanism since you obviously want to start a new game in both of these places. Don’t worry if you end up with some code duplication here (you probably don’t quite know enough Swift yet to factor this code out).
    
    func startNewGame() {
    //  Required Task 11. A new game should use a randomly chosen theme and touching the New Game button should repeatedly keep choosing a new random theme.
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(in: theme)
    }
    
    //  Hint 4. Since a Theme is now part of your Model, it must be UI-independent. Representing a color in a UI-independent way is surprisingly nuanced (not just in Swift, but in general). We recommend, therefore, that you represent a color in your Theme as a simple String which is the name of the color, e.g. “orange”. Then let your ViewModel do one of its most important jobs which is to “interpret” the Model for the View. It can provide the View access to the current theme’s color in a UI-dependent representation (like SwiftUI’s Color struct, for example).
    
    func getColor(of color: String) -> Color {
        switch color {
        case "Red":
            return .red
        case "Blue":
            return .blue
        case "Green":
            return .green
        case "Purple":
            return .purple
        case "Gray":
            return .gray
        case "Yellow":
            return .yellow
        default:
            return .orange
        }
    }
    
    //  Hint 11. You’ll very likely want to keep the static func createMemoryGame() from lecture to create a new memory game. But that function needs a little bit more information to do its job now, so you will almost certainly have to add an argument to it.
    
    static func createMemoryGame(in theme: Theme) -> MemoryGame<String> {
    //  Required Task 5. If the number of pairs of emoji to show in a Theme is fewer than the number of emojis that are available in that theme, then it should not just always use the first few emoji in the theme. It must use any of the emoji in the theme. In other words, do not have any “dead emoji” in your code that can never appear in a game.
        let emojis = theme.cards.shuffled()
        var pairs = theme.numberOfPairs
    //  Required Task 7. If a Theme mistakenly specifies to show more pairs of cards than there are emoji available, then automatically reduce the count of cards to show to match the count of available emoji.
        if pairs > emojis.count {
            pairs = emojis.count
        }
        let game = MemoryGame<String>(numberOfPairsOfCards: pairs) { pairIndex in
            emojis[pairIndex]
        }
        return game
    }
    
    //  Hint 2. Your ViewModel’s connection to its Model can consist of more than a single var model. It can be any number of vars. The “Model” is a conceptual entity, not a single struct.
    
    @Published private var model: MemoryGame<String>

    private(set) var theme: Theme
    
    var score: Int { model.score };
       
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
