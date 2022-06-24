//
//  Joueur.swift
//  Game
//
//  Created by edouard Kabia on 13/06/2022.
//

import Foundation

class Player: Any {
    
    //
    var characters : [Character] = [Character]()
    //
    var number : Int
    //
    static var charactersNames : [[Int : String]] = [[:]]
    
    static var playerNumber : Int = 0
    //
    /// Fonction d'initialisation permettant au joueur de constituer son équipe
    /// - Parameter number: Numéro du joueur
    init(number : Int) {
        self.number = number
        print("Bonjour,\nJoueur \(number) procédons à la construction de l'équipe")
        var numeroPersonnage = 1
        while self.characters.count < 3{
            print("Veuillez choisir le nom de votre personnage numéro \(numeroPersonnage)")
            //
            let characterName = getCharacterName()
            //
            print("Quelle type de personage sera \(characterName)\n0 - Colossus \n1 - Dwarf \n2 - Magus  \n3 - Warrior")
            let type = getCharacterType()
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
    }
    
    init(){
        Player.playerNumber += 1
        number = Player.playerNumber
        for i in 1...3{
            let _name = "P_\(number)_Charac_\(i)"
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
    }
    
    /// Permet d'obtenir un nombre entre 0 et 3 avec gestion des erreurs
    /// - Returns: Type de personnage entre 0 et 3
    private func getCharacterType() -> Int{
        //
        var numero = -1
        //
        while numero == -1 {
            if let type = readLine() {
                if let typeNumber = Int(type){
                    if(typeNumber >= 0 && typeNumber <= 3){
                        numero = typeNumber
                    }
                    else{
                        print("Veuillez saisir un numéro entre 0 et 3 ")
                    }
                }
                else {
                    print("numéro saisie invalide ")
                }
            }
        }
        return numero
    }
    
    private func getCharacterName() -> String{
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
    }
    
}
