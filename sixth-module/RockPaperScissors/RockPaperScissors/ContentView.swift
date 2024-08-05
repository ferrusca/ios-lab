//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jorge Ferrusca on 02/08/24.
//

import SwiftUI

struct GameResult: Identifiable {
    var id: Int
    var label: String
    var winner: String
}

struct Leaderboard {
    var computer = 0
    var user = 0
}

enum Weapon: String, CaseIterable {
    case rock
    case paper
    case scissors
}

struct ContentView: View {
    @State var results: [GameResult] = [];
    @State var animationCount: Double = 0
    @State var winner = "";
    @State var userSelection = "";
    @State var computerSelection = "";
    @State var leader = ""
    @State private var leaderboard = Leaderboard()
    
    
    private func playGame(weapon: Weapon) {
        userSelection = weapon.rawValue
        computerSelection = ["rock", "paper", "scissors"][Int.random(in: 0..<3)]
        print(userSelection)
        
        let result = rockPaperScissors(weapon: weapon, 
                                       computerSelection: computerSelection)
        
        winner = result.winner
        
        if result.winner == "computer" {
            leaderboard.computer += 1
        } else if result.winner == "user" {
            leaderboard.user += 1
        }
        
        results.append(result)
    }
    
    var body: some View {
        VStack {
            Text("Select an option")
                .font(.headline)
            HStack {
                Button {
                    playGame(weapon: .rock)
                    withAnimation(.easeIn) {
                        animationCount += 1
                        
                    }
                } label: {
                    Image("rock")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                Spacer()
                Button {
                    playGame(weapon: .paper)
                    withAnimation(.easeIn) {
                        animationCount += 1
                        
                    }
                } label: {
                    Image("paper")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                Spacer()
                Button {
                    playGame(weapon: .scissors)
                    withAnimation(.easeIn) {
                        animationCount += 1
                    }
                } label: {
                
                    Image("scissors")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                }
                
            }
            Text("You: \(userSelection)")
            Text("Computer: \(computerSelection)")
            Text("Winner: \(winner)")
                .animation(.easeInOut, value: leader)
            
            Spacer()
            Spacer()
            Spacer()
            
            HStack {
                Text("Leader: ")
                    .shake(count: animationCount)
                Text("\(leaderboard.computer > leaderboard.user ? "Computer" : leaderboard.user > leaderboard.computer ? "User" : "Tie")")   
                    .shake(count: animationCount)
            }
            
            List(results) { result in
                Text(result.label)
            }
            
            
        }
        .padding()
    }
}


// struct that defines a custom animation
struct Shake: ViewModifier, Animatable {
    var count: CGFloat = 0
    
    init(count: CGFloat) {
        self.count = count
    }
    
    var animatableData: CGFloat {
        get { count }
        set { count = newValue }
    }
    
    func body(content: Content) -> some View {
        print("count right now is \(count)")
        let offset = -sin(count * 2 * .pi) * 20
        return content.offset(x: offset)
    }
}

extension View {
    func shake(count: CGFloat) -> some View {
        modifier(Shake(count: count))
    }
}


#Preview {
    ContentView()
}

