//
//  RegisterViewController.swift
//  Cafe Maria
//
//  Created by Volodymyr Khvaliuk on 18.07.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    var user: UserProtocol?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func register() {
        user = User(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text)
        if user?.register() ?? false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
            self.navigationController?.viewControllers = [viewController]
        } else {
            let alertController = UIAlertController(title: "Data entered incorrectly", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func showPassword() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    
    @IBAction func ignoreSpaces(_ sender: UITextField) {
        sender.text! = sender.text!.replacingOccurrences(of: " ", with: "")
    }
    
}
