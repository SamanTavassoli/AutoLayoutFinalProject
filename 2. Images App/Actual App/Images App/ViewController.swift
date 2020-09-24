//
//  ViewController.swift
//  Images App
//
//  Created by Saman on 28/07/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var sideBySideCardSuperView: SideBySideCardSuperView!
    @IBOutlet var cardSuperView: CardSuperView!
    
    var cards: [Card]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBySideCardSuperView.stackView.referenceToViewController = self
        setCardChoices()
    }
    
    func setCardChoices() {
        var count = 0
        for cardView in sideBySideCardSuperView.stackView.subviews as! [CardView] {
            cardView.card = cards[count]
            count += 1
        }
    }
    func selectedCardChanged(to card: Card) {
        let change = cardSuperView.subviews[0] as! CardView
        change.switchCard(to: card)
    }
}

