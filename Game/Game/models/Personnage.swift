//
//  Personnage.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import UIKit

class Personnage: NSObject {
    // attributs
    var name : String = ""
    var health : Int = 0
    var damage : Int = 0
    //
    init(name : String, health : Int, damage : Int) {
        self.name = name
        self.health = health
        self.damage = damage
    }
    //
    func attack ( personnage : Personnage, damage : Int) -> Personnage{
        personnage.health -= damage
        return personnage
    }
        
}
