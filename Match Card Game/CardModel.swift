//
//  CardModel.swift
//  Match Card Game
//
//  Created by Mykola on 21.04.2023.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        // Declera an empty array
        var generatedCards = [Card]()
        // Array helper to track allready exists card
        var generatedNumbers = [Int]()
        
        // Card pairs generator
        repeat {
            let randomNumber = Int.random(in: 1...13)
            
            // Save number to array helper to shure we generate unique cards
            if !generatedNumbers.contains(randomNumber) {
                generatedNumbers.append(randomNumber)
                
                let cardOne = Card()
                let cardTwo = Card()
                
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                // Add them to the cards array
                generatedCards += [cardOne, cardTwo]
            }
        } while generatedCards.count < 16
        
        // Radomize the cards withing the array
        generatedCards.shuffle()
        
        return generatedCards
    }
}
