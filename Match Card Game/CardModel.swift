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
        
        // Randomly generate 8 pairs of cards
        repeat {

            // Generate random number
            let randomNumber = Int.random(in: 1...13)
            
            // Save number to array helper to shure we generate unique cards
            if generatedNumbers.contains(randomNumber) != true {
                generatedNumbers.append(randomNumber)
                
                // Create two new card objects
                let cardOne = Card()
                let cardTwo = Card()

                // Set their images
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                // Add them to the cards array
                generatedCards += [cardOne, cardTwo]
                
                print(randomNumber)

            }
        } while(generatedCards.count < 16)
        
        // Radomize the cards withing the array
        generatedCards.shuffle()
        print("Count", generatedCards.count)
        // Return the array
        return generatedCards
    }
}
