//
//  HarcodedPokemons.swift
//  Pokedex
//
//  Created by Jorge Ferrusca on 30/07/24.
//

import Foundation

// Currently unused.
// This was used before getting the data via poke API
var harcodedPokemons: [Pokemon] = [
    Pokemon(
        id: 11,
        name: "Bulbasaur",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
        number: "001",
//        pokedexInfo: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
        types: [.Grass, .Poison],
        evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
    ),
    Pokemon(
        id: 12,
        name: "Ivysaur",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png",
        number: "002",
//        pokedexInfo: "When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.",
        types: [.Grass, .Poison],
        evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
    ),
    Pokemon(
        id: 13,
        name: "Venusaur",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png",
        number: "003",
//        pokedexInfo: "The plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.",
        types: [.Grass, .Poison],
        evolutionChain: ["Bulbasaur", "Ivysaur", "Venusaur"]
   ),
    Pokemon(
        id: 14,
        name: "Charmander",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
        number: "004",
//        pokedexInfo: "Obviously prefers hot places. When it rains, steam is said to spout from the tip of its tail.",
        types: [.Fire],
        evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
    ),
    Pokemon(
        id: 15,
        name: "Charmeleon",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png",
        number: "005",
//        pokedexInfo: "When it swings its burning tail, it elevates the temperature to unbearably high levels.",
        types: [.Fire],
        evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
    ),
    Pokemon(
        id: 16,
        name: "Charizard",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png",
        number: "006",
//        pokedexInfo: "Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally.",
        types: [.Fire, .Flying],
        evolutionChain: ["Charmander", "Charmeleon", "Charizard"]
    ),
    Pokemon(
        id: 17,
        name: "Squirtle",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
        number: "007",
//        pokedexInfo: "After birth, its back swells and hardens into a shell. Powerfully sprays foam from its mouth.",
        types: [],
        evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
    ),
    Pokemon(
        id: 18,
        name: "Wartortle",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png",
        number: "008",
//        pokedexInfo: "Often hides in water to stalk unwary prey. For swimming fast, it moves its ears to maintain balance.",
        types: [.Water],
        evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
    ),
    Pokemon(
        id: 19,
        name: "Blastoise",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png",
        number: "009",
//        pokedexInfo: "A brutal Pokémon with pressurized water jets on its shell. They are used for high-speed tackles.",
        types: [.Water],
        evolutionChain: ["Squirtle", "Wartortle", "Blastoise"]
   ),
    Pokemon(
        id: 10,
        name: "Caterpie",
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png",
        number: "010",
//        pokedexInfo: "Its short feet are tipped with suction pads that enable it to tirelessly climb slopes and walls.",
        types: [.Bug],
        evolutionChain: ["Caterpie", "Metapod", "Butterfree"]
    )
];
