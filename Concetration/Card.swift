//
//  Card.swift
//  Concetration
//
//  Created by Sinisa Vukovic on 19/10/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import Foundation

struct Card: Hashable {
   
   var hashValue:Int { return identifier }
   
   public static func == (lhs: Card, rhs: Card) -> Bool {
      return lhs.identifier == rhs.identifier
   }
   
   var isFaceUp = false
   var isMatched = false
   private var identifier:Int

   private static var uniqueIdentifierFactory = 0
   
   private  static func getUniqueIdentifier() -> Int {
      uniqueIdentifierFactory += 1
      return uniqueIdentifierFactory
   }

   init() {
      self.identifier = Card.getUniqueIdentifier()
   }
}
