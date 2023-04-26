//
//  CardCollectionViewCell.swift
//  Match Card Game
//
//  Created by Mykola on 21.04.2023.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func configureCell(card: Card) {
        
        // Keep track of the card this cell represents
        self.card = card
        
        // Set the front image view to the image that represents the card
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        } else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        // Reset the state of the cell by checking the flipped status of the card and then showing the front or the back imageView
        if card.isFlipped == true {
            // Show front image view
            flipUP(speed: 0)
        } else {
            // Show back image view
            flipDown(speed: 0, delay: 0)
        }
    }
    
    func flipUP(speed: TimeInterval = 0.3) {
        
        // Flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        // Set the status of the card is flipped to the front
        card?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.3 , delay: TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            // Flip Down animation
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        }
        
        // Set the status of the card is flipped to the back
        card?.isFlipped = false
    }
    
    func remove() {
        
        // Make the image views invisible
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
    }
}
