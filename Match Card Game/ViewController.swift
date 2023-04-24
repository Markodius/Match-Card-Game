//
//  ViewController.swift
//  Match Card Game
//
//  Created by Mykola on 21.04.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
        // Set the view controller as a data source and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get card from the card array
        
        // TODO: Finish it -> Configure cell
        cell.configureCell(card: cardsArray[indexPath.row])
        
        // Return it
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get a referance to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check the status of the card to choose how to flip it
        if cell?.card?.isFlipped == false {
            
            // Flip card up
            cell?.flipUP()
        } else {
            
            // Flip card down
            cell?.flipDown()
        }
    }
}
