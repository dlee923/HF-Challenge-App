//
//  LoginViewController.swift
//  HF Test
//
//  Created by Daniel Lee on 5/11/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - UI Elements
    lazy var loginForm = LoginForm(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.3))
    
    // MARK: - Setup view methods
    private func setup() {
        self.view.backgroundColor = .white
        self.addLoginForm()
    }
    
    private func addLoginForm() {
        self.loginForm.loginDelegate = self
        self.view.addSubview(self.loginForm)
        self.loginForm.translatesAutoresizingMaskIntoConstraints = false
        self.loginForm.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginForm.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.loginForm.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        self.loginForm.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
}

protocol LoginDelegate {
    
    func captureUserInputsForSending()
    func loginUsingCredentials(username: String, password: String)
    
}

// MARK: Login methods for submitting data
extension LoginViewController: LoginDelegate {
    
    internal func captureUserInputsForSending() {
        let username = self.loginForm.userTextField.text ?? ""
        let password = self.loginForm.passwordTextField.text ?? ""
        
        // Validate username is an email
        if false {
            let alert = UIAlertController(title: "Invalid", message: "Please enter a valid username / email address", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.loginUsingCredentials(username: username, password: password)
        }
    }
    
    internal func loginUsingCredentials(username: String, password: String) {
        // Function to send login request to server should be placed here.
        print("Attemping to log in as \(username) with password: \(password)")
    }
    
}

