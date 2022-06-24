//
//  Colossus.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

class Colossus: Character{
    //
    convenience init(name: String) {
        self.init(name: name, maxLife: 150, damage: 6)
    }
}
