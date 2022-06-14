//
//  Warrior.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import UIKit

class Warrior: Personnage {
   
    convenience init(name: String) {
        self.init(name: name, health: 100, damage: 10)
    }
}
