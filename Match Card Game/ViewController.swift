//
//  ViewController.swift
//  Match Card Game
//
//  Created by Mykola on 21.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let model = CardModel()
    var cardsArray = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
    }


}

