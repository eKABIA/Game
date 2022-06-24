//
//  Dwarf.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

/// Extend from Character he is low life but higth Damage
class Dwarf: Character {
    convenience init(name: String) {
        self.init(name: name, maxLife: 90, damage: 15)
    }
}
