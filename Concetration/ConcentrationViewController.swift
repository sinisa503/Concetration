//
//  ViewController.swift
//  Concetration
//
//  Created by Sinisa Vukovic on 18/10/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

   private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
   
   var numberOfPairOfCards: Int {
      return cardButtons.count / 2
   }
   
   @IBOutlet private var cardButtons: [UIButton]!
   @IBOutlet private weak var flipCountLabel: UILabel! {
      didSet {
         updateFlipCountLabel()
      }
   }
   @IBAction private func touchCard(_ sender: UIButton) {
      flipCount += 1
      if let cardNumber = cardButtons.index(of: sender) {
         game.chooseCard(at: cardNumber)
         updateViewFromModel()
      }
   }
   
   private func updateViewFromModel() {
      guard cardButtons != nil else {
         return
      }
      for index in cardButtons.indices {
         let button = cardButtons[index]
         let card = game.cards[index]
         if card.isFaceUp {
            button.setTitle(emoji(for: card), for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
         }else {
            button.setTitle("", for: .normal)
            button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.580126236, blue: 0.01286631583, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
         }
      }
   }
   
   private(set) var flipCount = 0 {
      didSet {
         updateFlipCountLabel()
      }
   }

   private func updateFlipCountLabel() {
      let attributes:[NSAttributedString.Key:Any] = [
         .strokeWidth:5.0,
         .strokeColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      ]
      let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
      flipCountLabel.attributedText = attributedString
   }
   
   var theme:String? {
      didSet {
         emojiChoices = theme ?? ""
         emoji = [:]
         updateViewFromModel()
      }
   }
   
   //private var emojiChoices = ["👻","🤡","👿","🎃","🌞","🍄","🐳","🦀"]
   private var emojiChoices = "👻🤡👿🎃🌞🍄🐳🦀"
   
   private var emoji = [Card:String]()
   
   private func emoji(for card: Card) -> String {
      if emoji[card] == nil, emojiChoices.count > 0 {
         let emojiStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
         emoji[card] = String(emojiChoices.remove(at: emojiStringIndex))
      }
      return emoji[card] ?? "?"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }
}

extension Int {
   
   var arc4Random:Int {
      if self > 0 {
         return Int(arc4random_uniform(UInt32(self)))
      } else if self < 0 {
         return -Int(arc4random_uniform(UInt32(abs(self))))
      }else {
         return 0
      }
   }
}

