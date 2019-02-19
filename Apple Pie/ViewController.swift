//
//  ViewController.swift
//  Apple Pie
//
//  Created by rajeev on 2/18/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listofWords : [String] = ["cat","pizza","banana","swift","applepie"]
    
    let incorrectMovesAllowed = 7
    var totalWin = 0{
        didSet {
            newRound()
        }
    }
    var totalLosses = 0{
        didSet {
            newRound()
        }
    }
    var currentGame : Game!
    
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButton: [UIButton]!
    
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        //updateUI()
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            
        } else if currentGame.word == currentGame.formattedWord{
            totalWin += 1
        } else {
            updateUI()
        }
    }
    
    func newRound(){
        if !listofWords.isEmpty {
        let newWord = listofWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining : incorrectMovesAllowed, guessedLetters : [])
            enableLetterButton(true)
        updateUI()
        } else {
            enableLetterButton(false)
        }
    }
    
    func enableLetterButton(_ enable : Bool){
        for button in letterButton {
            button.isEnabled = enable
        }
    }
    
    func updateUI(){
        
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = " Wins : \(totalWin), Losses : \(totalLosses)"
        
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
}

