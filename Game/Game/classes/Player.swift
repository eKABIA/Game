//
//  Joueur.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation


/// A player forms a team of 3 characters.
/// Has a unique number.
/// - Attributs :
///     - characters : [Character] Created by the player at the start
///     - number : Int unique number of player can be set manually
///     - static var charactersNames : [[Int : String]] array to store all characters names of all player to maintain their uniqueness
///     - static var playerNumber : Intstatic var playerNumber : Int allow to générate automatically unique number of player
/// - Methods :
///     - private func getCharacterName() -> String
///     
class Player: Any {
    //
    var characters : [Character] = [Character]()
    //
    var number : Int = 0
    //
    var aliveChamps : [Character] { get { return self.characters.filter{!$0.isDead}}}
    //
    /// Initialization function allowing the player to build his team
    /// - Parameter number: player number
    /*init(number : Int) {
        self.number = number
        print("Bonjour,\nJoueur \(number) procédons à la construction de l'équipe")
        var numeroPersonnage = 1
        while self.characters.count < 3{
            print("Veuillez choisir le nom de votre personnage numéro \(numeroPersonnage)")
            //
            let characterName = Game.getCharacterName(numberPlayerNumber : self.number)
            //
            print("Quelle type de personage sera \(characterName)\n0 - Colossus \n1 - Dwarf \n2 - Magus  \n3 - Warrior")
            let type = SkyHelper().getNumber(min: 0, max: 3)
            switch type{
                case 0:
                    self.characters.append(Colossus(name: characterName))
                case 1:
                    self.characters.append(Dwarf(name: characterName))
                case 2:
                    self.characters.append(Magus(name: characterName))
                case 3:
                    self.characters.append(Warrior(name: characterName))
                default : break
            }
            numeroPersonnage += 1
        }
    }*/
    
    /// Initialization function allowing the player to build randomly his team
    /*init(){
        Game.playerNumber += 1
        self.number = Game.playerNumber
        for i in 1...3{
            let _name = "P_\(self.number)_Charac_\(i)"
            let type = Int.random(in: 0...3)
            switch type{
                case 0:
                    self.characters.append(Colossus(name: _name))
                case 1:
                    self.characters.append(Dwarf(name: _name))
                case 2:
                    self.characters.append(Magus(name: _name))
                case 3:
                    self.characters.append(Warrior(name: _name))
                default : break
            }
        }
    }*/
    
    /// Allows you to enter a new character name and maintain its uniqueness
    /// - Returns: The new created name and store it
    /*private func getCharacterName() -> String{
        var alreadyNamed = true
        var realName = ""
        while alreadyNamed{
            if let name = readLine(){
                realName = name
                alreadyNamed = false
                for elem in Player.charactersNames{
                    for (playerNumber, characterName) in elem{
                        if(name == characterName){
                            if(self.number == playerNumber){
                                print("Le nom \(name) est déja utilisé dans votre équipe, veuillez en saisir un autre.")
                                alreadyNamed = true
                                break
                            }
                            else{
                                print("Le nom \(name) est déja utilisé dans l'équipe adverse, veuillez en saisir un autre.")
                                alreadyNamed = true
                                break
                            }
                        }
                    }
                }
            }
        }
        Player.charactersNames.append([self.number : realName])
        return realName
    }*/
    
}
