//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kim Woonha on 17/7/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private(set) var score = 0
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            //  Required Task 15. Keep score in your game by penalizing 1 point for every previously seen card that is involved in a mismatch and giving 2 points for every match (whether or not the cards involved have been “previously seen”). See Hints below for a more detailed explanation. The score is allowed to be negative if the user is bad at Memorize.
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].isSeen {
                    score -= 1
                }
            //  Hint 19. A card has “already been seen” only if it has, at some point, been face up and then is turned back face down. So tracking “seen” cards is probably something you’ll want to do when you turn a card that is face up to be face down.
                cards[chosenIndex].isSeen = true
                cards[potentialMatchIndex].isSeen = true
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print(cards)
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
        //  Required Task 6. Never allow more than one pair of cards in a game to have the same emoji on it.
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    //  Required Task 13. The cards in a new game should be fully shuffled. This means that they are not in any predictable order, that they are selected from any of the emojis in the theme (i.e. Required Task 5), and also that the matching pairs are not all side-by-side like they were in lecture (though they can accidentally still appear side-by-side at random).
        cards.shuffle()
    }
    
    struct Card: Identifiable {
    //  Required Task 12. The cards in a new game should all start face down.
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    //  Hint 21. The “already been seen” concept is about specific cards that have already been seen, not emoji that have been seen.
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}

//  Hint 3. A Theme is a completely separate thing from a MemoryGame (even though both are part of your application’s Model). You should not need to modify a single line of code in MemoryGame.swift to support themes!

//  Required Task 3. Add the formal concept of a “Theme” to your Model. A Theme consists of a name for the theme, a set of emoji to use, a number of pairs of cards to show, and an appropriate color to use to draw the cards.

struct Theme {
    var name: String
    var cards: [String]
    var numberOfPairs: Int
    var color: String
}

//  Required Task 4. At least one Theme in your game should show fewer pairs of cards than the number of emoji available in that theme.
let vehicles = Theme(name: "Vehicles", cards: ["🚲","🚔","🛵","🚗",
                                                "🚕", "🚓", "🚚", "🚡",
                                                "🚙", "🚑", "🚛", "🚠",
                                                "🚌", "🚒", "🚜", "🚟",
                                                "🚎", "🚐", "🦼", "🚃",
                                                "🏎", "🛻", "🛴", "🚝",],
                    numberOfPairs: 8, color: "Blue")

let animals = Theme(name: "Animals", cards: ["🐶", "🐱", "🐭", "🐹",
                                           "🐰", "🦊", "🐻", "🐼","🐻‍❄️"],
                  numberOfPairs: 9, color: "Red")

let foods = Theme(name: "Foods", cards: ["🌭", "🍔", "🍟", "🍕",
                                         "🥪", "🧆", "🌮", "🌯",
                                         "🍝", "🍜", "🍛", "🍣"],
                  numberOfPairs: 12, color: "Green")

let buildings = Theme(name: "Buildings", cards: ["🏠", "🏛", "🏥", "🏪", "🏦", "⛪️"], numberOfPairs: 6, color: "Gray")

let pictures = Theme(name: "Pictures", cards: ["🎆", "🌠", "🌅", "🎑", "🌆", "🌉", "🌁"], numberOfPairs: 7, color: "Purple")

let drinks = Theme(name: "Drinks", cards: ["🥛", "🍺", "🍻", "🍷", "🥂", "🥃", "🍸", "🍹", "🍾"], numberOfPairs: 9, color: "Yellow")

//  Required Task 8. Support at least 6 different themes in your game.

var themes = [vehicles, animals, foods, buildings, pictures, drinks]
