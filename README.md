<div align="center"><h1>SuperSenha 🔐</h1></div>

## 📖 Introdução
SuperSenha é um aplicativo de geração de senhas projetado para ajudar os usuários a criar senhas seguras. Os usuários podem personalizar o número de senhas, o comprimento de cada senha e escolher se desejam incluir letras, números, letras maiúsculas e caracteres especiais.

### 🔑 PasswordGenerator

A classe PasswordGenerator lida com a lógica de geração de senhas aleatórias com base nos critérios definidos pelo usuário.

<b>Propriedades:</b>
- numberOfCharacters: Int - Número de caracteres em cada senha.
- useLetters: Bool - Incluir letras na senha.
- useNumbers: Bool - Incluir números na senha.
- useCapitalLetters: Bool - Incluir letras maiúsculas na senha.
- useSpecialCharacters: Bool - Incluir caracteres especiais na senha.
- passwords: [String] - Array para armazenar as senhas geradas.
  
```swift
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
        
        // Limita a quantidade de caracteres entre 1 e 16
        var numchars = min(numberOfCharacters, 16)
        numchars = max(numchars, 1)
        
        self.numberOfCharacters = numchars
        self.useLetters = useLetters
        self.useNumbers = useNumbers
        self.useSpecialCharacters = useSpecialCharacters
        self.useCapitalLetters = useCapitalLetters
    }
    
    // Gera a senha
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
        
        // Gera um número específico de senhas de acordo com as configurações do uso de letras, números...
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
```

### 📜 PasswordsViewController

O PasswordsViewController exibe as senhas geradas e lida com as interações do usuário para gerar novas senhas.

<b>Propriedades:</b>
- @IBOutlet weak var passwordsTv: UITextView! - TextView para exibir as senhas.
- numbersOfCharacters: Int - Número de caracteres por senha.
- numberOfPasswords: Int - Número de senhas a serem geradas.
- useLetters: Bool - Incluir letras nas senhas.
- useNumbers: Bool - Incluir números nas senhas.
- useCapitalLetters: Bool - Incluir letras maiúsculas nas senhas.
- useSpecialCharacters: Bool - Incluir caracteres especiais nas senhas.
- passwordGenerator: PasswordGenerator! - Instância do PasswordGenerator.

```swift
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
    
    func generatePasswords() {
        passwordsTv.scrollRangeToVisible(NSRange(location: 0, length: 0))
        passwordsTv.text = ""
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        // Quebra espaço entre as senhas
        for password in passwords {
            passwordsTv.text.append(password + "\n\n")
        }
    }
    
    @IBAction func generate(_ sender: UIButton) {
        generatePasswords()
    }
}
```

### 🔧 ViewController
O ViewController principal coleta as preferências do usuário para a geração de senhas e as passa para o PasswordsViewController.

<b>Propriedades:</b>
- @IBOutlet weak var totalPasswordTf: UITextField! - Campo de texto para o número total de senhas.
- @IBOutlet weak var numberOfCharactersTf: UITextField! - Campo de texto para o número de caracteres por senha.
- @IBOutlet weak var lettersSw: UISwitch! - Switch para incluir letras.
- @IBOutlet weak var numbersSw: UISwitch! - Switch para incluir números.
- @IBOutlet weak var capitalLettersSw: UISwitch! - Switch para incluir letras maiúsculas.
- @IBOutlet weak var specialCharactersSw: UISwitch! - Switch para incluir caracteres especiais.

```swift
class ViewController: UIViewController {
    
    @IBOutlet weak var totalPasswordTf: UITextField!
    @IBOutlet weak var numberOfCharactersTf: UITextField!
    @IBOutlet weak var lettersSw: UISwitch!
    @IBOutlet weak var numbersSw: UISwitch!
    @IBOutlet weak var capitalLettersSw: UISwitch!
    @IBOutlet weak var specialCharactersSw: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Faça qualquer configuração adicional após carregar a view.
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
```

## 🔄 Navegação
### Uso de Segues e NavigationController
No SuperSenha, a navegação entre telas é gerenciada através de um NavigationController e segues:

<b>1. ViewController (Tela Principal):</b>
- O usuário insere suas preferências (quantidade de senhas, número de caracteres, tipos de caracteres).
  
<b>2. Segue: </b>
- Quando o usuário inicia a geração de senhas, uma segue é acionada para transitar do ViewController para o PasswordsViewController.
  
<b>3. prepare(for segue:)</b>
- Antes da transição ocorrer, o método prepare(for segue:) no ViewController é chamado. Esse método prepara o PasswordsViewController passando todas as preferências do usuário.
  
<b>4.PasswordsViewController (Tela de Senhas Geradas):</b>
- Recebe os dados via prepare(for segue:) e utiliza o PasswordGenerator para criar e exibir as senhas.

O uso de um NavigationController permite que o usuário navegue facilmente entre as telas e retorne às configurações iniciais para ajustar os parâmetros de geração de senhas conforme necessário.

## 🚀 Como Rodar o Projeto
* **Clone o Repositório:**

```sh
git clone https://github.com/vrortega/SuperSenha.git
cd SuperSenha
```
* **Abra o Projeto no Xcode:**

Navegue até o arquivo `SuperSenha.xcodeproj` e abra-o com o Xcode.

* **Instale as Dependências:**

Se o projeto utilizar CocoaPods, execute `pod install` para instalar as dependências necessárias.

* **Compile e Rode o Projeto:**

Pressione `Cmd + R` ou clique no botão de rodar no Xcode.


## 📖 Referência
Projeto desenvolvido como parte do <a href="https://www.udemy.com/course/curso-completo-de-desenvolvimento-ios11swift4" target="_blank">
curso de desenvolvimento iOS, do Desenvolvedor Eric Alves Brito</a>.
