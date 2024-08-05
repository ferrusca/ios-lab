////
////  ContentView.swift
////  RockPaperScissors
////
////  Created by Jorge Ferrusca on 02/08/24.
////
//
//import SwiftUI
//
//struct GameResult2: Identifiable {
//    var id: Int
//    var label: String
//    var winner: String
//}
//
//struct Leaderboard2 {
//    var computer = 0
//    var user = 0
//}
//
//enum Weapon2: String, CaseIterable {
//    case rock
//    case paper
//    case scissors
//}
//
//struct ContentView2: View {
//    @State var results: [GameResult2] = [];
//    @State var winner = "";
//    @State var userSelection: Weapon2;
//    @State var computerSelection: Weapon2
//    @State var leader = ""
//    @State private var leaderboard = Leaderboard2()
//    
//    
//    private func playGame(weapon: Weapon2) {
//        userSelection = weapon
//        computerSelection = Weapon2.allCases.randomElement() ?? .paper
//        
//        print(userSelection)
//        
//        let result = rockPaperScissors(weapon: weapon,
//                                       computerSelection: computerSelection)
//        
//        winner = result.winner
//        
//        if result.winner == "computer" {
//            leaderboard.computer += 1
//        } else if result.winner == "user" {
//            leaderboard.user += 1
//        }
//        
//        results.append(result)
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Select an option")
//                .font(.headline)
//            HStack {
//                Button {
//                    playGame(weapon: .rock)
//                } label: {
//                    Image("rock")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                }
//                Spacer()
//                Button {
//                    playGame(weapon: .paper)
//                } label: {
//                    Image("paper")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                }
//                Spacer()
//                Button {
//                    playGame(weapon: .scissors)
//                } label: {
//                
//                    Image("scissors")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                    
//                }
//                
//            }
//            Text("You: \(userSelection)")
//            Text("Computer: \(computerSelection)")
//            Text("Winner: \(winner)")
//            
//            Spacer()
//            Spacer()
//            Spacer()
//            
//            HStack {
//                Text("Leader: ")
//                Spacer()
//                Text("\(leaderboard.computer > leaderboard.user ? "Computer" : leaderboard.user > leaderboard.computer ? "User" : "Tie")")
//            }
//            
//            List(results) { result in
//                Text(result.label)
//            }
//            
//            
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView2()
//}
