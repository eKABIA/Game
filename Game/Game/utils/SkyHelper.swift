//
//  SkyHelper.swift
//  Game
//
//  Created by edouard Kabia on 24/06/2022.
//

import Foundation

/// Helper Structure for all common usual fonction
struct SkyHelper{
    
    /// help function for getting a number between to other number and return error if mistake is done by user
    /// this will loop while a valid number isn't inserted
    /// - Parameters:
    ///   - min: min number to give
    ///   - max: max number to give
    /// - Returns: retrun selected number
     func getNumber(min : Int, max : Int) -> Int{
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
}

/// Enum for managing demo mode and normal mode
enum GameMode{
    case Normal
    case Demo
}
