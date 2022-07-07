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
///
class Game: Any {
    //
    private var isPlayerOneToStart = false
    //
    private var playerOne = Player()
    private var playerTwo = Player()
    //
    //var playerOneDeathChamp : [Character] = [Character]()
    //var playerTwoDeathChamp : [Character] = [Character]()
    //
    //static var charactersNames : [[Int : String]] = [[:]]
    //
    private var playerNumber : Int = 0
    //
    init(gameMode : GameMode){
         createPlayer(self.playerOne, gameMode: gameMode)
         createPlayer(self.playerTwo ,gameMode: gameMode)
        /*if(gameMode == GameMode.Demo){
            self.playerOne = Player()
            self.playerTwo = Player()
        }
        else {
            self.playerOne = Player(number: 1)
            self.playerTwo = Player(number: 2)
        }*/
    }
    // MARK: - Player Building
    /// initialisation of our player
    /// - Parameters:
    ///   - player: the player to initialize, by creating characters team and number
    ///   - gameMode: the mode normal game is your have time or demo mode like a  good lazy dev
    private func createPlayer(_ player : Player, gameMode : GameMode){
        self.playerNumber += 1
        player.number = self.playerNumber
        print("Bonjour,\nJoueur \(player.number) procédons à la construction de l'équipe")
        var numeroPersonnage = 1
        while player.characters.count < 3{
            var characterName = ""
            /*gameMode == GameMode.Normal ? print("Veuillez choisir le nom de votre personnage numéro \(numeroPersonnage)")
            : print("Votre personnage numéro \(numeroPersonnage) obtient le nom \(characterName)")
            */
            if gameMode == GameMode.Normal {
                print("Veuillez choisir le nom de votre personnage numéro \(numeroPersonnage)")
                characterName = getCharacterName(player: player, gameMode: gameMode)
            }
            else {
                characterName = getCharacterName(player: player, gameMode: gameMode)
                print("Votre personnage numéro \(numeroPersonnage) obtient le nom \(characterName)")
            }
            print("Quelle type de personage sera \(characterName)\n0 - Colossus \n1 - Dwarf \n2 - Magus  \n3 - Warrior")
            let type = gameMode == GameMode.Normal ? SkyHelper().getNumber(min: 0, max: 3) : Int.random(in: 0...3)
            
            switch type{
                case 0:
                    player.characters.append(Colossus(name: characterName))
                case 1:
                    player.characters.append(Dwarf(name: characterName))
                case 2:
                    player.characters.append(Magus(name: characterName))
                case 3:
                    player.characters.append(Warrior(name: characterName))
                default : break
            }
            numeroPersonnage += 1
        }
    }
    
    // MARK: -
    /// Allows you to enter a new character name and maintain its uniqueness
    /// - Parameters:
    ///   - player: player trying to get a new character name
    ///   - gameMode: gameMode  Normal or Demo (whith demo you get random cool name ^^)
    /// - Returns: The new created name
    private func getCharacterName( player : Player, gameMode : GameMode) -> String{
        var alreadyNamed = true
        var realName = ""
        while alreadyNamed{
            // get name by user
            if gameMode == GameMode.Normal {
                if let name = readLine(){ realName = name }
            }
            // get random name from ou helper
            else {
                realName = SkyHelper().characterNames[Int.random(in: 0..<SkyHelper().characterNames.count)]
            }
            //
            if player.characters.compactMap({$0.name}).contains(where: {$0 == realName}){
                alreadyNamed = true
                gameMode == GameMode.Normal ? print("Le nom \(realName) est déja utilisé dans votre équipe, veuillez en saisir un autre.") : nil
            }
            else if checkNameInPlayerCharacter(playerNumber: player.number, name: realName) && gameMode == GameMode.Normal {
                alreadyNamed = true
                print("Le nom \(realName) est déja utilisé dans l'équipe adverse, veuillez en saisir un autre.")
            }
            else {
                alreadyNamed = false
            }
            //
            /*if let name = readLine(){
                realName = name
                alreadyNamed = false
                
                for elem in charactersNames{
                    for (playerNumber, characterName) in elem{
                        if(name == characterName){
                            numberPlayerNumber == playerNumber ? print("Le nom \(name) est déja utilisé dans votre équipe, veuillez en saisir un autre.")
                            : print("Le nom \(name) est déja utilisé dans l'équipe adverse, veuillez en saisir un autre.")
    
                            alreadyNamed = true
                            break
                        }
                    }
                }
            }*/
        }
        return realName
    }
    
    /// this function will check on character of other player for taking car about character name
    /// - Parameters:
    ///   - playerNumber: player who try to create chartacter name
    ///   - name: name tried by the player
    /// - Returns: result if already exist or not
    private func checkNameInPlayerCharacter (playerNumber : Int, name : String) -> Bool{
        return (playerNumber == 1 ) ? playerTwo.characters.compactMap{ $0.name }.contains{ $0 == name }
        : playerOne.characters.compactMap{ $0.name }.contains{ $0 == name }
    }
    
    
    // MARK: - Start
    
    /// Beginning of the game. Random choice of the player starting the first round and manages the turn by turn as well as the end of the game and launches the display of stats.
    func fight(){
        //
        print("Le combat est sur le point de commencer on va déterminer au hasard le joueur qui commence !")
        //
        sleep(3)
        characterRecap()
        //
        self.isPlayerOneToStart =  Int.random(in: 1...100) % 2 == 0 ? true : false
        self.isPlayerOneToStart ? print("Joueur n°1 Commence !!") : print("Joueur n°2 Commence !!")
        //
        while (playerOne.aliveChamps.count > 0 && playerTwo.aliveChamps.count > 0){
            self.isPlayerOneToStart ? selectCharacter(playerOne) : selectCharacter(playerTwo)
            self.isPlayerOneToStart = !self.isPlayerOneToStart
        }
        //
        finishAndStats(player : (playerOne.characters.count > 0 ? playerOne : playerTwo))
        
    }
    // MARK: - Choosing character and action
    /// Display player character and allow selection of one of them and ask for action.
    /// - Parameter player: player reference
    private func selectCharacter(_ player : Player){
        print("Joueur \(player.number) Choisissez un de vos champion")
        for i in 0..<player.aliveChamps.count {
            print("\(i) - \(player.aliveChamps[i].name) -> \(String(describing: type(of: player.aliveChamps[i].self))) vie -> \(player.aliveChamps[i].life) -> dégats -> \(player.aliveChamps[i].damage)")
        }
        if(gameMode == GameMode.Demo){
            let select = Int.random(in: 0..<player.aliveChamps.count)
            print(select)
            selectAction(player.aliveChamps[select])
        }
        else {
            selectAction(player.aliveChamps[SkyHelper().getNumber(min: 0, max: player.aliveChamps.count - 1)])
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
            hitEnemiChamp(self.isPlayerOneToStart ? self.playerTwo : self.playerOne, character) :
            healTeam(self.isPlayerOneToStart ? self.playerOne : self.playerTwo, character)
        }
        else {
            hitEnemiChamp(self.isPlayerOneToStart ? self.playerTwo : self.playerOne, character)
        }
    }
    // MARK: - Action execution
    /// Special function for Magus perform an heal on allies
    /// - Parameters:
    ///   - player: player to get his characters
    ///   - character: the magus character to perform and heal
    private func healTeam(_ player : Player,_ character : Character){
        print("Choisissez un personnage à soigner")
        for i in 0..<player.aliveChamps.count {
            print("\(i) - \(player.aliveChamps[i].name) -> \(String(describing: type(of: player.aliveChamps[i].self))) vie -> \(player.aliveChamps[i].life) -> dégats -> \(player.aliveChamps[i].damage)")
        }
        var healed = -1
        if(gameMode == GameMode.Demo){
            healed = Int.random(in: 0..<player.aliveChamps.count)
            print(healed)
        }
        else {
            healed = SkyHelper().getNumber(min: 0, max: player.aliveChamps.count - 1)
        }
        (character as? Magus)?.heal(player.aliveChamps[healed])
    }
    
    /// Perform and attack on enemie to make damage and check their remaining life
    /// - Parameters:
    ///   - player: enemi player to get his characters
    ///   - character: the character we made the attack
    private func hitEnemiChamp(_ player : Player,_ character : Character){
        print("Choisissez un personnage enemi à attaquer")
        for i in 0..<player.aliveChamps.count {
            print("\(i) - \(player.aliveChamps[i].name) -> \(String(describing: type(of: player.aliveChamps[i].self))) vie -> \(player.aliveChamps[i].life) -> dégats -> \(player.aliveChamps[i].damage)")
        }
        var hited = -1
        if(gameMode == GameMode.Demo){
            print("perso restant sur le player n° \(player.number)  = \(player.aliveChamps.count)")
            hited = Int.random(in: 0..<player.aliveChamps.count)
            print(hited)
        }
        else {
            hited = SkyHelper().getNumber(min: 0, max: player.aliveChamps.count - 1)
        }
        
        character.attack(player.characters[hited])
        //check death
        // TODO 2 variable calculé dans player
        // mort / vif
        /*if player.characters[hited].isDead {
            player.number == 1 ?
            self.playerOneDeathChamp.append(player.characters.remove(at: hited)) :
            self.playerTwoDeathChamp.append(player.characters.remove(at: hited))
        }*/
    }
    
    // MARK: -  Affichage
    /// Make a quick and simple wiew of team composition
    private func characterRecap(){
        print("\nJoueur 1")
        print("\(self.playerOne.characters[0].name) ==> \(String(describing: type(of: self.playerOne.characters[0].self)))")
        print("\(self.playerOne.characters[1].name) ==> \(String(describing: type(of: self.playerOne.characters[1].self)))")
        print("\(self.playerOne.characters[2].name) ==> \(String(describing: type(of: self.playerOne.characters[2].self)))")
        
        print("\nJoueur 2")
        print("\(self.playerTwo.characters[0].name) ==> \(String(describing: type(of: self.playerTwo.characters[0].self)))")
        print("\(self.playerTwo.characters[1].name) ==> \(String(describing: type(of: self.playerTwo.characters[1].self)))")
        print("\(self.playerTwo.characters[2].name) ==> \(String(describing: type(of: self.playerTwo.characters[2].self)))\n")
    }
    
    //
    /// Print the stat of a player characters after the end of the game
    /// - Parameter player: <#player description#>
    private func finishAndStats(player : Player){
        print("LE GAGNANT EST  \(player.number) !!!! \nFELICITATION !!!")
        print("Bien Joué à ton adversaire  ^^\n")
        //
        /*for i in 0...player.characters.count - 1 {
            player.number == 1 ?
            playerOneDeathChamp.append(player.characters[i]) :
            playerTwoDeathChamp.append(player.characters[i])
        }*/
        // todo draw stats
        player.number == 1 ? drawStat(number : 1 , characters: self.playerOne.characters) : drawStat(number : 2, characters: self.playerTwo.characters)
        player.number == 1 ? drawStat(number : 2, characters: self.playerTwo.characters) : drawStat(number : 1, characters: self.playerOne.characters)
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
