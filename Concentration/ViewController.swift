//
//  ViewController.swift
//  Concentration
//
//  Created by Sebastian Pfeufer on 29/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var emojiThemesMaster = [
        ["ðĶ", "ðą", "ð", "ð", "ð", "ðŧ", "ð", "ð―"],
        ["ðĪ", "ð", "ðĪĐ", "ð", "ðĪŠ", "ð", "ð", "ð"],
        ["â", "ðĪ", "ð", "ð", "ð", "ðŠ", "ð", "ð"],
        ["ðââïļ", "ðĩïļ", "ð§âð", "ðĻâðĪ", "ð§âðŦ", "ðŪââïļ", "ðĐâðŧ", "ðĐâð"],
        ["ð", "ðĢ", "ðļ", "ðž", "ð", "ðĶ", "ðĶ", "ð"],
        ["ðą", "ð", "ð", "ðĨ", "âūïļ", "ð", "ð", "â―ïļ"]
    ]
    
    private lazy var emojiThemes = emojiThemesMaster
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }

    private lazy var themeNumber = emojiThemes.count.arc4random

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        game.startNewGame()
        updateViewFromModel()
        themeNumber = emojiThemes.count.arc4random
        emojiThemes = emojiThemesMaster
        emoji = [Int: String]()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }

    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiThemes[themeNumber].count > 0 {
            emoji[card.identifier] = emojiThemes[themeNumber].remove(at: emojiThemes[themeNumber].count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

