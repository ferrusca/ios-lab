import Foundation

// Ejercicio: Serpientes y escaleras

func game(diceRolls: [Int]) -> Void {
    var currentPosition = 0;

    let maxPosition = 24
    let jumps = [2: 8, 5: 11, 8 :9, 9: 2, 13: -10, 18: -11 ,21: -11, 23: -8];
    
    for dice in diceRolls {
        print("\nEstas en la casilla: \(currentPosition)\nTirando dado...")
        sleep(2)
        print("El valor del dado es \(dice)\nAvanzando...")
        currentPosition += dice
        print("Llegaste a la posicion \(currentPosition > maxPosition ? maxPosition : currentPosition)")
        if let jump = jumps[currentPosition] {
            currentPosition += jump
            print("Caiste en \(jump > 0 ? "Escalera" : "Serpiente")!, tu nueva posicion es \(currentPosition)")
        }
        
        if (currentPosition >= 24) {
            print("Ganaste!")
            break
        }
    }
    
}

let rolls = [2,3,5,6,5,4]
game(diceRolls: rolls)
