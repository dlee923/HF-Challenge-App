//
//  LoginViewController.swift
//  HF Test
//
//  Created by Daniel Lee on 5/11/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    // MARK: - Mutable Properties
    let userLbl = UILabel()
    let userTextField = UITextField()
    let passwordLbl = UILabel()
    let passwordTextField = UITextField()
    let userInfoStackView = UIStackView()
    let submitButton = UIButton()
    
    // MARK: - Setup methods and adding views
    private func setup() {
        self.view.backgroundColor = .white
        self.userTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.addUserInputBox()
        self.userInputBoxConstraints()
        self.modifySubmitButton()
        self.modifyTextFields()
    }
    
    private func addUserInputBox() {
        self.view.addSubview(userInfoStackView)
        self.userInfoStackView.addArrangedSubview(self.userLbl)
        self.userInfoStackView.addArrangedSubview(self.userTextField)
        self.userInfoStackView.addArrangedSubview(self.passwordLbl)
        self.userInfoStackView.addArrangedSubview(self.passwordTextField)
        self.view.addSubview(self.submitButton)
        
        self.userInfoStackView.stackProperties(axis: .vertical, spacing: 0, alignment: .fill, distribution: .fillEqually)
    }
    
    private func userInputBoxConstraints() {
        self.userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        self.userInfoStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.userInfoStackView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.userInfoStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        self.userInfoStackView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.topAnchor.constraint(equalTo: self.userInfoStackView.bottomAnchor, constant: 10).isActive = true
        self.submitButton.leadingAnchor.constraint(equalTo: self.userInfoStackView.leadingAnchor).isActive = true
        self.submitButton.trailingAnchor.constraint(equalTo: self.userInfoStackView.trailingAnchor).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func modifyTextFields() {
        self.userLbl.font = UIFont.fontCoolvetica?.withSize(15)
        self.userLbl.text = "Username"
        self.userTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        self.userTextField.borderStyle = .bezel
        
        self.passwordLbl.font = UIFont.fontCoolvetica?.withSize(15)
        self.passwordLbl.text = "Password"
        self.passwordTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        self.passwordTextField.borderStyle = .bezel
    }
    
    private func modifySubmitButton() {
        self.submitButton.layer.cornerRadius = 10
        self.submitButton.backgroundColor = UIColor.color1
        self.submitButton.setTitleColor(.black, for: .normal)
        self.submitButton.layer.borderWidth = 2
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.addShadow(path: UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: 55)),
                                    color: .black,
                                    offset: CGSize(width: 3.0, height: 3.0),
                                    radius: 5,
                                    opacity: 0.5)
    }

}
