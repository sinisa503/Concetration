//
//  Concentration.swift
//  Concetration
//
//  Created by Sinisa Vukovic on 19/10/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import Foundation

struct  Concentration {
   
   private(set) var cards = [Card]()
   private var idexOfFaceUpCard:Int? {
      get {
         return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
      }
      set {
         for index in cards.indices {
            cards[index].isFaceUp = index == newValue
         }
      }
   }
   
   public mutating func chooseCard(at index:Int) {
      assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): Chosen index not in the cards")
      if !cards[index].isMatched {
         if let matchIndex = idexOfFaceUpCard, matchIndex != index {
            if cards[matchIndex] == cards[index] {
               cards[matchIndex].isMatched = true
               cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
         }else {
            idexOfFaceUpCard = index
         }
      }
   }
   
   init(numberOfPairOfCards:Int) {
      assert(numberOfPairOfCards > 0, "Concentration.init(\(numberOfPairOfCards)): You must have at least one pair of cards")
      for _ in 1...numberOfPairOfCards {
         let card = Card()
         cards += [card, card]
      }
      cards.shuffle()
   }
   
}

extension Collection {
   
   var oneAndOnly:Element? {
      return count == 1 ? first : nil
   }
}
