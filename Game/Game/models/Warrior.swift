//
//  Warrior.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//
import Foundation

/// Extend from Character he is equilibrate life and damage
class Warrior: Character {
    
    convenience init(name: String) {
        self.init(name: name, maxLife: 100, damage: 10)
    }
}
