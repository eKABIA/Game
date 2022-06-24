//
//  Personnage.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation


/// Base class of all characters type
///  - Attributs  :
///     - name : desired name
///     - maxLife : base life
///     - life : actual life
///     - damage : damage of this character
///     - damageSuffered : damage inflicted to this character
///     - damageInflicted : damage inflicted by this character
///     - healingReceived : life received by this character
///     - numberOfTurn : Number of turns made with this character
///
/// - Methods :
///     - attack (_ attacked : Character)
///
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
    /// Constructor
    /// - Parameters:
    ///   - name: desired name of the character
    ///   - maxLife: maximum life of the character, allows to initialize the basic life
    ///   - damage: damage that your characted inflicte to your enemies
    init(name : String, maxLife : Int, damage : Int) {
        self.name = name
        self.maxLife = maxLife
        self.life = maxLife
        self.damage = damage
    }
    //
    ///Allows you to perform an attack on a character and update other attributs for further stats
    /// - Parameter attacked: targeted character
    func attack (_ attacked : Character){
        attacked.life -= self.damage
        attacked.damageSuffered += self.damage
        self.damageInflicted += self.damage
        self.numberOfTurn += 1
    }
}
