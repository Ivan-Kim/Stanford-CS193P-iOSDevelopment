//
//  ContentView.swift
//  Memorize
//
//  Created by Kim Woonha on 13/7/21.
//

import SwiftUI

let vehicles = ["🚲","🚔","🛵","🚗",
                "🚕", "🚓", "🚚", "🚡",
                "🚙", "🚑", "🚛", "🚠",
                "🚌", "🚒", "🚜", "🚟",
                "🚎", "🚐", "🦼", "🚃",
                "🏎", "🛻", "🛴", "🚝",]

let animals = ["🐶", "🐱", "🐭", "🐹",
               "🐰", "🦊", "🐻", "🐼","🐻‍❄️"]

let foods = ["🌭", "🍔", "🍟", "🍕",
            "🥪", "🧆", "🌮", "🌯",
            "🍝", "🍜", "🍛", "🍣"]

func widthThatBestFits(cardCount: Int) -> CGFloat {
    return 65
}

struct ContentView: View {
    @State var emojis = vehicles
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
            ScrollView {
                let random = Int.random(in: 4...emojis.count)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: random)))]) {
                    ForEach(emojis[0..<random],
                            id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Button{
                    emojis = vehicles.shuffled()
                } label: {
                    ThemeView(themeText: "Vehicles",
                              themeImage: "car")
                }
                Spacer()
                Button {
                    emojis = animals.shuffled()
                } label: {
                    ThemeView(themeText: "Animals",
                              themeImage: "hare")
                }
                Spacer()
                Button {
                    emojis = foods.shuffled()
                } label: {
                    ThemeView(themeText: "Foods",
                              themeImage: "mouth")
                }
            }
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            .padding(.all)
        }
        .padding(.horizontal)
    }
}

struct ThemeView: View {
    var themeText: String
    var themeImage: String
    
    var body: some View {
        VStack {
            Image(systemName: themeImage)
            Text(themeText).font(.body)
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
            
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
