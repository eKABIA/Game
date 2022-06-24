//
//  Jeu.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

class Game: Any {
    
    //
    enum GameMode{
        case Normal
        case Demo
    }
    //
    var isPlayerOneToStart = false
    //
    let playerOne : Player
    let playerTwo : Player
    //
    var playerOneDeathChamp : [Character] = [Character]()
    var playerTwoDeathChamp : [Character] = [Character]()
    
    init(){
        playerOne = Player()
        playerTwo = Player()
    }
    
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
    
    private func selectCharacter(_ player : Player){
        print("Joueur \(player.number) Choisissez un de vos champion")
        for i in 0...player.characters.count - 1 {
            print("\(i) - \(player.characters[i].name) -> \(String(describing: type(of: player.characters[i].self))) life -> \(player.characters[i].life) -> damage -> \(player.characters[i].damage)")
        }
        selectAction(player.characters[getNumber(min: 0, max: player.characters.count - 1)])
    }
    
    private func selectAction(_ character : Character){
        if(character is Magus){
            print("0 - Attaquer ")
            print("1 - Soigner ")
            let action = getNumber(min: 0, max: 1)
            action == 0 ?
                hitEnemiChamp(isPlayerOneToStart ? playerTwo : playerOne, character) :
                healTeam(isPlayerOneToStart ? playerOne : playerTwo, character)
        }
        else {
            hitEnemiChamp(isPlayerOneToStart ? playerTwo : playerOne, character)
        }
    }
    
    private func healTeam(_ player : Player,_ character : Character){
        print("Choisissez un personnage à soigner")
        for i in 0...player.characters.count - 1 {
            print("\(i) - \(player.characters[i].name) -> \(String(describing: type(of: player.characters[i].self))) life -> \(player.characters[i].life) -> damage -> \(player.characters[i].damage)")
        }
        let healed = getNumber(min: 0, max: player.characters.count - 1)
        (character as? Magus)?.heal(player.characters[healed])
    }
    
    private func hitEnemiChamp(_ player : Player,_ character : Character){
        print("Choisissez un personnage enemi à attaquer")
        for i in 0...player.characters.count - 1 {
            print("\(i) - \(player.characters[i].name) -> \(String(describing: type(of: player.characters[i].self))) life -> \(player.characters[i].life) -> damage -> \(player.characters[i].damage)")
        }
        let hited = getNumber(min: 0, max: player.characters.count - 1)
        character.attack(player.characters[hited])
        //check death
        if(player.characters[hited].life <= 0){
            player.number == 1 ?
            playerOneDeathChamp.append(player.characters.remove(at: hited)) :
            playerTwoDeathChamp.append(player.characters.remove(at: hited))
        }
    }
    
    private func characterRecap(){
        print("\nPlayer 1")
        print("\(playerOne.characters[0].name) ==> \(String(describing: type(of: playerOne.characters[0].self)))")
        print("\(playerOne.characters[1].name) ==> \(String(describing: type(of: playerOne.characters[1].self)))")
        print("\(playerOne.characters[2].name) ==> \(String(describing: type(of: playerOne.characters[2].self)))")
        
        print("\nPlayer 2")
        print("\(playerTwo.characters[0].name) ==> \(String(describing: type(of: playerTwo.characters[0].self)))")
        print("\(playerTwo.characters[1].name) ==> \(String(describing: type(of: playerTwo.characters[1].self)))")
        print("\(playerTwo.characters[2].name) ==> \(String(describing: type(of: playerTwo.characters[2].self)))\n")
    }
    
    private func getNumber(min : Int, max : Int) -> Int{
        //
        var numero = -1
        //
        while numero == -1 {
            if let type = readLine() {
                if let typeNumber = Int(type){
                    if(typeNumber >= min && typeNumber <= max){
                        numero = typeNumber
                    }
                    else{
                        print("Veuillez saisir un numéro entre \(min) et \(max) ")
                    }
                }
                else {
                    print("numéro saisie invalide ")
                }
            }
        }
        return numero
    }
    //
    private func finishAndStats(player : Player){
        print("WINNER IS PLAYER \(player.number) !!!! \nCONGRATULATIONS !!!")
        print("\nNice Game to your enemi ^^")
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
    
    private func drawStat(number : Int,characters : [Character]){
        print("Player \(number) champs")
        for elem in characters{
            var life_provided = 0
            if let magus = elem as? Magus{
                life_provided = magus.lifeProvided
            }
            print("name \(elem.name) type \(String(describing: type(of: elem.self))) damage suffered \(elem.damageSuffered) damage inflicted \(elem.damageInflicted) healing received \(elem.healingReceived) life provided \(life_provided) number of turn \(elem.numberOfTurn)")
        }
    }
}
