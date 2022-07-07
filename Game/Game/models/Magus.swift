//
//  Magus.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

/// Extend from Character he is Strong life but low Damage and he gt heal adventage
/// - Attributs :
///     - lifeProvided Int : Total life provided by him in game
/// - Methods : ```` func heal (_ character : Character) ````
///
///
class Magus : Character {
    
    var lifeProvided : Int = 0
    //
    convenience init(name: String) {
        self.init(name: name, maxLife: 150, damage: 4)
    }
    
    //
    /// Better heal allies than you, this methode add life to character and update other attributs for further stats
    /// - Parameter character: the healed
    func heal (_ character : Character){
        
        var healValue : Int = 0
        
        if (self.name == character.name){ healValue = self.damage }
        else { healValue = 7}
        
        healed(healValue: healValue)
        /*
        if((character.life + healValue) > character.maxLife ) { character.life = character.maxLife }

        else {character.life += healValue}

        character.healingReceived += healValue*/
        self.lifeProvided += healValue
        
        self.numberOfTurn += 1
    }
    
    private func healed(healValue : Int){
        if self.life + healValue > self.maxLife { self.life = self.maxLife }
        else { self.life += healValue}
        self.healingReceived += healValue
    }
}
