//
//  Magus.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

class Magus : Character {
    
    var lifeProvided : Int = 0
    //
    convenience init(name: String) {
        self.init(name: name, maxLife: 150, damage: 4)
    }
    
    // better heal allies than you ^^
    func heal (_ character : Character){
        var healValue : Int = 0
        
        if (self.name == character.name){ healValue = self.damage }
        else { healValue = 7}
           
            
        if((character.life + healValue) > character.maxLife ) { character.life = character.maxLife }

        else {character.life += healValue}
        
        self.lifeProvided += healValue
        
        character.healingReceived += healValue
        
        self.numberOfTurn += 1
        
    }
}
