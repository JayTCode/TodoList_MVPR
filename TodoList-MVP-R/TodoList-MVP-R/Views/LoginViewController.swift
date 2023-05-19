//
//  LoginViewController.swift
//  TodoList-MVP-R
//
//  Created by Jason Ta on 2023-05-12.
//

import UIKit

class LoginViewController: UIViewController {
    
    let container = UIView()
    
    private let stackView = UIStackView()
    
    private let usernameTextField = UITextField()

    private let passwordTextField = UITextField()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.contentMode = .center
        loginButton.tintColor = .systemCyan
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(container)
        container.backgroundColor = .systemRed
        container.frame(forAlignmentRect: CGRect(x: 149, y: 367, width: 393, height: 120))
        
        viewConfigs()
        
        view.addSubview(stackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
}

//MARK: - View Configurations -

extension LoginViewController {
    
    func viewConfigs() {
        stackViewConfig()
        defaultTextFieldConfig()
        userNameTextFieldConfig()
        passwordTextFieldConfig()
    }
    
    func stackViewConfig() {
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        // Constraints
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    func defaultTextFieldConfig() {
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.borderStyle = .line
        usernameTextField.keyboardType = .default
        usernameTextField.font = .preferredFont(forTextStyle: .body)
        usernameTextField.minimumFontSize = 12.0
    }
    
    func userNameTextFieldConfig() {
        usernameTextField.backgroundColor = .systemRed
        usernameTextField.placeholder = "Username"
        usernameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    func passwordTextFieldConfig() {
        passwordTextField.backgroundColor = .systemBlue
        passwordTextField.placeholder = "Password"
        passwordTextField.textContentType = .password
        passwordTextField.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
