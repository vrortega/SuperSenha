//
//  PasswordGenerator.swift
//  SuperSenha
//
//  Created by Vitoria Ortega on 27/05/24.
//

import Foundation

class PasswordGenerator {
    var numberOfCharacters: Int
    var useLetters: Bool
    var useNumbers: Bool
    var useCapitalLetters: Bool
    var useSpecialCharacters: Bool
    
    var passwords: [String] = []
    
    private let letters = "abcdefghijklmnopqrstuvwyz"
    private let specialCharacters = "!@#$%ˆ&*()_-+=][.><;:'"
    private let numbers = "0123456789"
    
    init(numberOfCharacters: Int,
         useLetters: Bool,
         useNumbers: Bool,
         useCapitalLetters: Bool, useSpecialCharacters: Bool) {
        
        // limita a quantidade de caracteres entre 1 a 16
        var numchars = min(numberOfCharacters, 16)
        numchars = max(numchars, 1)
        
        self.numberOfCharacters = numchars
        self.useLetters = useLetters
        self.useNumbers = useNumbers
        self.useSpecialCharacters = useSpecialCharacters
        self.useCapitalLetters = useCapitalLetters
    }
    
    // gera a senha
    func generate(total: Int) -> [String] {
        passwords.removeAll()
        var universe: String = ""
        
        if useLetters {
            universe += letters
        }
        if useNumbers {
            universe += numbers
        }
        if useSpecialCharacters {
            universe += specialCharacters
        }
        if useCapitalLetters {
            universe += letters.uppercased()
        }
        
        let universeArray = Array(universe)
        
        // gera um número especifico de senhas de acordo com as conf do uso de letras, números...
        while passwords.count < total {
            var password = ""
            for _ in 1...numberOfCharacters {
                let index = Int(arc4random_uniform(UInt32(universeArray.count)))
                password += String(universeArray[index])
            }
            passwords.append(password)
        }
        return passwords
    }
}
