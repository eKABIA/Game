//
//  Jeu.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

/// Base class to manage the whole game process
///
/// - Attributs :
///     - isPlayerOneToStart : used for turn by turn
///     - playerOne : Player
///     - playerTwo : Player
///     - playerOneDeathChamp
///     - playerTwoDeathChamp
///
class Game: Any {
    //
    var isPlayerOneToStart = false
    //
    let playerOne : Player
    let playerTwo : Player
    //
    var playerOneDeathChamp : [Character] = [Character]()
    var playerTwoDeathChamp : [Character] = [Character]()
    
    init(gameMode : GameMode){
        if(gameMode == GameMode.Demo){
            playerOne = Player()
            playerTwo = Player()
        }
        else {
            playerOne = Player(number: 1)
            playerTwo = Player(number: 2)
        }
    }
    // MARK: - Start
    
    /// Beginning of the game. Random choice of the player starting the first round and manages the turn by turn as well as the end of the game and launches the display of stats.
    func figth(){
        print("Le combat est sur le point de commencer on va déterminer au hasard le joueur qui commence !")
        sleep(3)
        characterRecap()
        let winner = Int.random(in: 1...100)
        if((winner % 2) == 0){
            print("Player 1 Commence !!")
            isPlayerOneToStart = true
        } else {
            print("Player 2 Commence !!")
            isPlayerOneToStart = false
        }
        //
        while (playerOne.characters.count > 0 && playerTwo.characters.count > 0){
            isPlayerOneToStart ? selectCharacter(playerOne) : selectCharacter(playerTwo)
            isPlayerOneToStart = !isPlayerOneToStart
        }
        //
        finishAndStats(player : (playerOne.characters.count > 0 ? playerOne : playerTwo))
    }
    // MARK: - Choosing character and action
    /// Display player character and allow selection of one of them and ask for action.
    /// - Parameter player: player reference
    private func selectCharacter(_ player : Player){
        print("Joueur \(player.number) Choisissez un de vos champion")
        for i in 0...player.characters.count - 1 {
            print("\(i) - \(player.characters[i].name) -> \(String(describing: type(of: player.characters[i].self))) vie -> \(player.characters[i].life) -> dégats -> \(player.characters[i].damage)")
        }
        if(gameMode == GameMode.Demo){
            let select = Int.random(in: 0...(player.characters.count - 1))
            print(select)
            selectAction(player.characters[select])
        }
        else {
            selectAction(player.characters[SkyHelper().getNumber(min: 0, max: player.characters.count - 1)])
        }
        
    }
    
    /// perform an action depending on the character
    /// - Parameter character:the charage for performing an action
    private func selectAction(_ character : Character){
        if(character is Magus){
            print("0 - Attaquer ")
            print("1 - Soigner ")
            var action = -1
            if(gameMode == GameMode.Demo){
                action = Int.random(in: 0...1)
                print(action)
            }
            else {
                action = SkyHelper().getNumber(min: 0, max: 1)
            }
            action == 0 ?
                hitEnemiChamp(isPlayerOneToStart ? playerTwo : playerOne, character) :
                healTeam(isPlayerOneToStart ? playerOne : playerTwo, character)
        }
        else {
            hitEnemiChamp(isPlayerOneToStart ? playerTwo : playerOne, character)
        }
    }
    // MARK: - Action execution
    /// Special function for Magus perform an heal on allies
    /// - Parameters:
    ///   - player: player to get his characters
    ///   - character: the magus character to perform and heal
    private func healTeam(_ player : Player,_ character : Character){
        print("Choisissez un personnage à soigner")
        for i in 0...player.characters.count - 1 {
            print("\(i) - \(player.characters[i].name) -> \(String(describing: type(of: player.characters[i].self))) vie -> \(player.characters[i].life) -> dégats -> \(player.characters[i].damage)")
        }
        var healed = -1
        if(gameMode == GameMode.Demo){
            healed = Int.random(in: 0...(player.characters.count - 1))
            print(healed)
        }
        else {
            healed = SkyHelper().getNumber(min: 0, max: player.characters.count - 1)
        }
        (character as? Magus)?.heal(player.characters[healed])
    }
    
    /// Perform and attack on enemie to make damage and check their remaining life
    /// - Parameters:
    ///   - player: enemi player to get his characters
    ///   - character: the character we made the attack
    private func hitEnemiChamp(_ player : Player,_ character : Character){
        print("Choisissez un personnage enemi à attaquer")
        for i in 0...player.characters.count - 1 {
            print("\(i) - \(player.characters[i].name) -> \(String(describing: type(of: player.characters[i].self))) vie -> \(player.characters[i].life) -> dégats -> \(player.characters[i].damage)")
        }
        var hited = -1
        if(gameMode == GameMode.Demo){
            hited = Int.random(in: 0...(player.characters.count - 1))
            print(hited)
        }
        else {
            hited = SkyHelper().getNumber(min: 0, max: player.characters.count - 1)
        }
        
        character.attack(player.characters[hited])
        //check death
        if(player.characters[hited].life <= 0){
            player.number == 1 ?
            playerOneDeathChamp.append(player.characters.remove(at: hited)) :
            playerTwoDeathChamp.append(player.characters.remove(at: hited))
        }
    }
    
    // MARK: -  Affichage
    /// Make a quick and simple wiew of team composition
    private func characterRecap(){
        print("\nJoueur 1")
        print("\(playerOne.characters[0].name) ==> \(String(describing: type(of: playerOne.characters[0].self)))")
        print("\(playerOne.characters[1].name) ==> \(String(describing: type(of: playerOne.characters[1].self)))")
        print("\(playerOne.characters[2].name) ==> \(String(describing: type(of: playerOne.characters[2].self)))")
        
        print("\nJoueur 2")
        print("\(playerTwo.characters[0].name) ==> \(String(describing: type(of: playerTwo.characters[0].self)))")
        print("\(playerTwo.characters[1].name) ==> \(String(describing: type(of: playerTwo.characters[1].self)))")
        print("\(playerTwo.characters[2].name) ==> \(String(describing: type(of: playerTwo.characters[2].self)))\n")
    }
    
    //
    /// Print the stat of a player characters after the end of the game
    /// - Parameter player: <#player description#>
    private func finishAndStats(player : Player){
        print("LE GAGNANT EST  \(player.number) !!!! \nFELICITATION !!!")
        print("Bien Joué à ton adversaire  ^^\n")
        //
        for i in 0...player.characters.count - 1 {
            player.number == 1 ?
            playerOneDeathChamp.append(player.characters[i]) :
            playerTwoDeathChamp.append(player.characters[i])
        }
        // todo draw stats
        player.number == 1 ? drawStat(number : 1 , characters: playerOneDeathChamp) : drawStat(number : 2, characters: playerTwoDeathChamp)
        player.number == 1 ? drawStat(number : 2, characters: playerTwoDeathChamp) : drawStat(number : 1, characters: playerOneDeathChamp)
    }
    //
    /// Stats printer loop througth array and print desired information for stat
    /// - Parameters:
    ///   - number: number of player
    ///   - characters: array of characters
    private func drawStat(number : Int,characters : [Character]){
        print("Joueur \(number) Personnages")
        for elem in characters{
            var life_provided = 0
            if let magus = elem as? Magus{
                life_provided = magus.lifeProvided
            }
            print("nom \(elem.name) type \(String(describing: type(of: elem.self))) dégats subis \(elem.damageSuffered) dégats infligé \(elem.damageInflicted) vie reçu \(elem.healingReceived) vie fournie \(life_provided) nombre de tour \(elem.numberOfTurn)")
        }
    }
    // MARK: -
}
