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
        
        // Randomly generate 8 pairs of cards
        for _ in 1...8 {
            
            // Generate a random number
            let randomNumber = Int.random(in: 1...13)
            
            // Create two new card object
            let cardOne = Card()
            let cardTwo = Card()
            
            // Set their names
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            // Add them to the array
            generatedCards += [cardOne, cardTwo]
        }
        // Radomize the cards withing the array
        generatedCards.shuffle()
        
        // Return the array
        return generatedCards
    }
}
