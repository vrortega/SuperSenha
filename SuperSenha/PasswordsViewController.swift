//
//  PasswordsViewController.swift
//  SuperSenha
//
//  Created by Vitoria Ortega on 27/05/24.
//

import UIKit

class PasswordsViewController: UIViewController {
    
    @IBOutlet weak var passwordsTv: UITextView!
    
    var numbersOfCharacters: Int = 10
    var numberOfPasswords: Int = 1
    var useLetters: Bool!
    var useNumbers: Bool!
    var useCapitalLetters: Bool!
    var useSpecialCharacters: Bool!
    
    var passwordGenerator: PasswordGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Total de senhas: \(numberOfPasswords)"
        passwordGenerator = PasswordGenerator(numberOfCharacters: numbersOfCharacters, useLetters: useLetters, useNumbers: useNumbers, useCapitalLetters: useCapitalLetters, useSpecialCharacters: useSpecialCharacters)
        
        generatePasswords()
        
    }
    func generatePasswords(){
        passwordsTv.scrollRangeToVisible(NSRange(location: 0, length: 0))
        passwordsTv.text = ""
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        // quebra espaco entre as senhas
        for password in passwords {
            passwordsTv.text.append(password + "\n\n")
        }
    }
    
    
    @IBAction func generate(_ sender: UIButton) {
        generatePasswords()
    }
    
}
