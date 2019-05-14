//
//  LoginForm.swift
//  HF Test
//
//  Created by Daniel Lee on 5/11/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class LoginForm: UIView, UITextFieldDelegate {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.passwordTextField.delegate = self
        self.userTextField.delegate = self
        
        self.addUserInputBox()
        self.userInputBoxConstraints()
        self.modifyTextFields()
        self.modifySubmitButton()
    }
    
    // MARK: - Constant Properties
    let submitButtonHeightMultiplier: CGFloat = 0.25
    
    // MARK: - Mutable Properties
    weak var loginDelegate: LoginDelegate?
    
    // MARK: - UI Elements
    let userLbl = UILabel()
    let userTextField = UITextField()
    let passwordLbl = UILabel()
    let passwordTextField = UITextField()
    let spacer = UIView()
    let userInfoStackView = UIStackView()
    let submitButton = UIButton()
    
    // MARK: - Setup methods and adding and modifying views
    internal func addUserInputBox() {
        self.addSubview(userInfoStackView)
        self.userInfoStackView.addArrangedSubview(self.userLbl)
        self.userInfoStackView.addArrangedSubview(self.userTextField)
        self.userInfoStackView.addArrangedSubview(self.passwordLbl)
        self.userInfoStackView.addArrangedSubview(self.passwordTextField)
        self.userInfoStackView.addArrangedSubview(self.spacer)
        self.addSubview(self.submitButton)
        
        self.userInfoStackView.stackProperties(axis: .vertical, spacing: 0, alignment: .fill, distribution: .fillEqually)
    }
    
    private func userInputBoxConstraints() {
        self.userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        self.userInfoStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.userInfoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.userInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.userInfoStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: (1 - submitButtonHeightMultiplier)).isActive = true
        
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.topAnchor.constraint(equalTo: self.userInfoStackView.bottomAnchor, constant: 10).isActive = true
        self.submitButton.leadingAnchor.constraint(equalTo: self.userInfoStackView.leadingAnchor).isActive = true
        self.submitButton.trailingAnchor.constraint(equalTo: self.userInfoStackView.trailingAnchor).isActive = true
        self.submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.submitButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * submitButtonHeightMultiplier)
    }
    
    internal func modifyTextFields() {
        self.userLbl.font = UIFont.fontCoolvetica?.withSize(15)
        self.userLbl.text = "Username"
        self.userTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        self.userTextField.borderStyle = .bezel
        self.userTextField.placeholder = "Email address"
        
        self.passwordLbl.font = UIFont.fontCoolvetica?.withSize(15)
        self.passwordLbl.text = "Password"
        self.passwordTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        self.passwordTextField.borderStyle = .bezel
        self.passwordTextField.placeholder = "Password"
        self.passwordTextField.isSecureTextEntry = true
    }
    
    private func modifySubmitButton() {
        self.submitButton.layer.cornerRadius = 10
        self.submitButton.backgroundColor = UIColor.color1
        self.submitButton.setTitleColor(.black, for: .normal)
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.addShadow(path: UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.submitButton.frame.width, height: self.submitButton.frame.height)),
                                    color: UIColor.black.withAlphaComponent(0.8),
                                    offset: CGSize(width: 1.5, height: 1.5),
                                    radius: 4,
                                    opacity: 0.3)
        self.submitButton.addTarget(self, action: #selector(submitButtonMethod), for: .touchUpInside)
    }
    
    // MARK: - Submit button method
    @objc private func submitButtonMethod() {
        self.loginDelegate?.captureUserInputsForSending()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
