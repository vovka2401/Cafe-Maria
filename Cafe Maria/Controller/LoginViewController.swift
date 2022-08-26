//
//  ViewController.swift
//  Cafe Maria
//
//  Created by Volodymyr Khvaliuk on 17.07.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    var user: UserProtocol?
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func login() {
        user = User(email: emailTextField.text, password: passwordTextField.text)
        if user?.login() ?? false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
            self.navigationController?.viewControllers = [viewController]
        }
    }
    
    @IBAction func showPassword() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func ignoreSpaces(_ sender: UITextField) {
        sender.text! = sender.text!.replacingOccurrences(of: " ", with: "")
    }
}

