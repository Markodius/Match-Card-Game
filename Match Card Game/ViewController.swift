//
//  ViewController.swift
//  Match Card Game
//
//  Created by Mykola on 21.04.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var timer: Timer?
    var milliseconds: Int = 30 * 1000
    
    var firstFlippedCardIndex: IndexPath?
    var secondFlippedCard: IndexPath?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
        // Set the view controller as a data source and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    // MARK: - Timer Methods
    
    @objc func timerFired() {
        // Decrement counter
        milliseconds -= 1
        
        // Update label
        let seconds: Double = Double(milliseconds) / 1000.0
        timerLabel.text = String(format: "Time Renaining: %.2f", seconds)
        
        // Stop the timer if it reach zero
        if milliseconds == 0 {
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
            
            // Check if the user has cleared all pairs
            checkForGameEnd()
        }
    }
    
    // MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Return it
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // Configure the state of the cell based on the properties of the Card that it represents
        let cardCell = cell as? CardCollectionViewCell
        
        // Get card from the card array
        cardCell?.configureCell(card: cardsArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get a referance to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check the status of the card to choose how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            // Flip card up
            cell?.flipUP()
            
            // Check if this is the first card flipped or second
            
            if firstFlippedCardIndex == nil {
                
                // This is the first card flipped
                firstFlippedCardIndex = indexPath
                
            } else {
                
                // Second card flipped
                
                // Run comperison logic
                checkForMatch(indexPath)
            }
            
        }

    }
    
    // MARK: - Game Logic Methods
    
    func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
        
        // Get two card objects for the two indices and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        // Get the two collection view cells that represent card one and two
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            // It's match
            
            // Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // Was that the last pair?
            checkForGameEnd()
        }
        else {
            
            // It's not a match
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip them back
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex Property
        firstFlippedCardIndex = nil
    }
    
    func checkForGameEnd() {
        // Check if there's any card tht is on match
        // Assume the user has won, loop throught all the cards to see if all of them are matched
        var hasWon = true
        
        for card in cardsArray {
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon {
            // user has won, show an alert
            showAlert(title: "Congratulations!", message: "You've won the game!")
        } else {
            // User hasn't won yet. Check of there's any tine left
            showAlert(title: "Time;s ", message: <#T##String#>)
        }
        
    }
    
    func showAlert(title: String, message: String) {
        // Create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add a button for the user to dismis it
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
        // Show the alert
        present(alert, animated: true, completion: nil)
    }
}
