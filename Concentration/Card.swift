//
//  Card.swift
//  Concentration
//
//  Created by Sebastian Pfeufer on 29/12/2020.
//

import Foundation

struct Card {

    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
