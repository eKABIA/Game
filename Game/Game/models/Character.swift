//
//  Personnage.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

class Character: Any {
    // attributs
    var name : String = ""
    var maxLife : Int = 0
    var life : Int = 0
    var damage : Int = 0
    var damageSuffered: Int = 0
    var damageInflicted: Int = 0
    var healingReceived : Int = 0
    var numberOfTurn : Int = 0
    //
    init(name : String, maxLife : Int, damage : Int) {
        self.name = name
        self.maxLife = maxLife
        self.life = maxLife
        self.damage = damage
    }
    //
    func attack (_ attacked : Character){
        attacked.life -= self.damage
        attacked.damageSuffered += self.damage
        self.damageInflicted += self.damage
        self.numberOfTurn += 1
    }
        
}
