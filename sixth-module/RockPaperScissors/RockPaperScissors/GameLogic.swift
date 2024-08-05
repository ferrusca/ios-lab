//
//  GameLogic.swift
//  RockPaperScissors
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import Foundation

var count = 0

func rockPaperScissors(weapon: Weapon, computerSelection: String) -> GameResult {
    var result = GameResult(id: count,
                            label: "\(weapon.rawValue) vs \(computerSelection)",
                            winner: "")
    count = count + 1
    
    if (weapon.rawValue == computerSelection) {
        result.winner = "tie"
    } else {
        switch weapon {
        case .paper:
            result.winner = computerSelection == "rock"
            ? "user"
            : "computer"         // computer: scissors
        case .rock:
            result.winner = computerSelection == "paper"
            ? "computer"
            : "user" // computer: scissors
        case .scissors:
            result.winner = computerSelection == "rock" ? "computer" : "user"
        }
    }
    
    result.label = "\(result.label) --> \(result.winner)"
    
    return result
}

//func getWinner(user: Weapon2, compute: Weapon2) -> String {
//    switch (user, compute):
//case (.paper, .rock), (.sci)
//    return S"User"
//}
