//
//  ViewController.swift
//  SuperSenha
//
//  Created by Vitoria Ortega on 27/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalPasswordTf: UITextField!
    @IBOutlet weak var numberOfCharactersTf: UITextField!
    @IBOutlet weak var lettersSw: UISwitch!
    @IBOutlet weak var numbersSw: UISwitch!
    @IBOutlet weak var capitalLettersSw: UISwitch!
    @IBOutlet weak var specialCharactersSw: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let passwordsViewController = segue.destination as! PasswordsViewController
        if let numberOfPasswords = Int(totalPasswordTf.text!) {
            passwordsViewController.numberOfPasswords = numberOfPasswords
        }
        if let numberOfCharacters = Int(numberOfCharactersTf.text!){
            passwordsViewController.numbersOfCharacters = numberOfCharacters
        }
        passwordsViewController.useLetters = lettersSw.isOn
        passwordsViewController.useNumbers = numbersSw.isOn
        passwordsViewController.useCapitalLetters = capitalLettersSw.isOn
        passwordsViewController.useSpecialCharacters = specialCharactersSw.isOn
        view.endEditing(true)
    }
    
}

