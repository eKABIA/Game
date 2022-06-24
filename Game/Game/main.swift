//
//  main.swift
//  Game
//
//  Created by edouard Kabia on 14/06/2022.
//

import Foundation

print("BIENVENUE DANS GAME ! \n")
// by defaut we go for nomal
var gameMode = GameMode.Normal
//printing some info for user
print("Veuillez choisir le mode que vous souhaitiez ")
print("0 - Mode Normal (2 Joueurs tour par tour)")
print("1 - Mode Demo (Laissez l'aléatoire parler pour tout le monde)")
// Chose your mode to start the game
// 0 - normal mode
// 1 - demo mode all is going well with random
var result = SkyHelper().getNumber(min: 0, max: 1)
// setting game mode
result == 0 ? (gameMode = GameMode.Normal) : (gameMode = GameMode.Demo)
// initializing our game class with selected game mode
var game = Game(gameMode : gameMode)
// start the game and enjoy
game.figth()



